import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phone_number/phone_number.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class User{

  User({required this.phoneNumber, required this.username});

  final String? phoneNumber;
  final String? username;

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'username': username,
    };
  }
}

abstract class DatabaseUtility {

  Database? database;
  bool? isOpen;

  Future<bool> saveData(String tablename, String key, dynamic data);
  Future<dynamic> getData(String tablename, String key);
  Future<bool> deleteData(String tablename, String key);
  Future<bool> syncDatabases(Database otherDatabase);
  Future<bool> openDB(String path);

}

class LocalDB extends DatabaseUtility{
  

  

  @override
  Future<bool>  deleteData(String tablename, String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future getData(String tablename, String key) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<bool>  saveData(String tablename, String key, data) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

  @override
  Future<bool>  syncDatabases(Database otherDatabase) {
    // TODO: implement syncDatabases
    throw UnimplementedError();
  }
  
  @override
  Future<bool> openDB(String path) async {
  database =await openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'ulak_database.db'),
  // When the database is first created, create a table to store dogs.
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      'CREATE TABLE users(phoneNumber TEXT PRIMARY KEY, username TEXT)',
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);
  return true;
    
  }

}

class FirebaseDB extends DatabaseUtility{
  @override
  Future<bool> deleteData(String tablename, String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future getData(String tablename, String key) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<bool> saveData(String tablename, String key, data) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

  @override
  Future<bool> syncDatabases(Database otherDatabase) {
    // TODO: implement syncDatabases
    throw UnimplementedError();
  }
  
  @override
  Future<bool> openDB(String path) {
    // TODO: implement openDatabase
    throw UnimplementedError();
  }
  
}

class SmsResultPackgage{

  SmsResultPackgage({this.message, this.result});

  String? message;
  bool? result;
}


//Currently designed for usual authentication, with completed tables data type requested can be changed
class Authentication {
  
  LocalDB localDB = LocalDB();
  FirebaseDB firebaseDB = FirebaseDB();

  //Takes phone number as argument and sends sms to that number with a random 6 digit number
  //returns true if sms is sent successfully else returns false
  Future<SmsResultPackgage> signInSmsSender(String phoneNumber) async {

    RegionInfo region = const RegionInfo(code:"TR" ,name:"Turkey" ,prefix:90);
    bool isPhoneNumberValid = await PhoneNumberUtil().validate(phoneNumber, regionCode: region.code);

    if(isPhoneNumberValid){
      String message=Random().nextInt(899999)+100000 as String;
      bool smsResult=await smsSender(message, [phoneNumber]);

      return SmsResultPackgage(message: message, result: smsResult);

    }
    else{
      return SmsResultPackgage(message: "No code sended because of invalid phone number", result: false);
    }
  }

  //If entered code entered by user is equal to the code sended by signInSmsSender function save user to databases and shared preferences
  //If save is successful returns true else returns false
  Future<bool> signInSmsCodeChecker(String phoneNumber, String username,String? code,String? enteredCode) async { 
    if(code==enteredCode){
      
      bool firebaseResult = await firebaseDB.saveData("users", phoneNumber, username);

      if(firebaseResult){
        bool localResult = await localDB.saveData("users",phoneNumber, username);

        if(localResult){
          SharedPreferences preferences = await SharedPreferences.getInstance();
          bool phoneNumberResult = await preferences.setString("phoneNumber", phoneNumber);
          if (phoneNumberResult) {
            bool usernameResult = await preferences.setString("username", username);
            return usernameResult;
          }
          else{
            return false;
          }
        }
        else{
          return false;
        }
      }
      else{
        return false;
      }

    }
    else{
      return false;
    }

  }


  Future<bool> login(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // TODO: check if phone number is the device phone number,
    // TODO: if so then check if it exists in database,
    // TODO: if so then save it to local database and also to shared preferences then return true else return false
  
    bool result1 = await prefs.setString('phoneNumber', phoneNumber);

    return result1;
    
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result1 = await prefs.remove('phoneNumber');
    return result1;
  }

  Future<bool> isLogin(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString('phoneNumber');

    if (phoneNumber != null ) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> returnPhoneNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString('phoneNumber');
    return phoneNumber!;
  }
}




class AuthenticationHelper{

  Future<bool> isPhoneNumberValid(String phoneNumber)async{
    RegionInfo region = const RegionInfo(code:"TR" ,name:"Turkey" ,prefix:90);
    return await PhoneNumberUtil().validate(phoneNumber, regionCode: region.code);

  }

  Future<bool> smsSender(String message, List<String> recipents) async {
    
  
    return true;
  }

}


