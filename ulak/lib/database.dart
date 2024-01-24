import 'dart:ffi';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phone_number/phone_number.dart';


abstract class Database {
  Future<bool> saveData(String tablename, String key, dynamic data);
  Future<dynamic> getData(String tablename, String key);
  Future<bool> deleteData(String tablename, String key);
  Future<bool> syncDatabases();
}

class LocalDB extends Database{
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
  Future<bool>  syncDatabases() {
    // TODO: implement syncDatabases
    throw UnimplementedError();
  }

}

class FirebaseDB extends Database{
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
  Future<bool> syncDatabases() {
    // TODO: implement syncDatabases
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
  Future<bool> signInSmsCodeChecker(String phoneNumber, String username,String code,String enteredCode) async { 
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
    String? phone_number = prefs.getString('phoneNumber');
    return phone_number!;
  }
}



Future<bool> isPhoneNumberValid(String phoneNumber)async{
  RegionInfo region = const RegionInfo(code:"TR" ,name:"Turkey" ,prefix:90);
  return await PhoneNumberUtil().validate(phoneNumber, regionCode: region.code);

}

Future<bool> smsSender(String message, List<String> recipents) async {
  
 
  return true;
}

