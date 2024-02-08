//Currently designed for usual authentication, with completed tables data type requested can be changed
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phone_number/phone_number.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Authentication {
  
  LocalDB localDB = LocalDB();
  FirebaseDB firebaseDB = FirebaseDB();

  

  //If entered code entered by user is equal to the code sended by signInSmsSender function save user to databases and shared preferences
  //If save is successful returns true else returns false

  //Takes phone number as argument and sends sms to that number with a random 6 digit number
  //returns SMSResultPackgage object with message and result fields

  Future<SmsResultPackgage> registerSendSMS(String phoneNumber)async {

    if(! await AuthenticationHelper.isPhoneNumberValid(phoneNumber)){
      print("Phone number is not valid");
      return SmsResultPackgage(message: "Phone number is not valid", result: false);
    }
    print("Before internet check");
    if(await InternetConnectionChecker().hasConnection){
      final users= await firebaseDB.getUsers();

      for (var user in users) {
        
        if(user.phoneNumber==phoneNumber){
          print("User already exists");
          return SmsResultPackgage(message: "User already exists", result: false);
        }
      }
   
      String code = (Random().nextInt(900000) + 100000).toString();
      print("Before SMS send");
      final smsSendResult= await AuthenticationHelper.smsSender(code, [phoneNumber]);
      print("After SMS send"  );


      return SmsResultPackgage(message: code, result: smsSendResult);
    }
    else{
      return SmsResultPackgage(message: "No internet connection", result: false);
    }


  }

  Future<bool> registerVerifySMS(String code,String userEntry, String phoneNumber,String username)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(code==userEntry){
      firebaseDB.saveUser(User(phoneNumber: phoneNumber, username: username));
      localDB.saveUser(User(phoneNumber: phoneNumber, username: username));
      prefs.setString('phoneNumber', phoneNumber);
      prefs.setString('username', username);
      return true;
    }
    else{
      return false;
    }
  }
  


  Future<bool> login(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
  
    localDB.getUsers().then((users) {
      for (var user in users) {
        if(user.phoneNumber==phoneNumber){
          prefs.setString('phoneNumber', phoneNumber);
          prefs.setString("username", user.username??"");
          return true;
        }
      }
    });
    return false;
      
    
    
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result1 = await prefs.remove('phoneNumber');
    bool result2 = await prefs.remove('username');
    return result1 && result2;
  }

  Future<bool> isLogin() async {
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

  static Future<bool> isPhoneNumberValid(String phoneNumber)async{
    RegionInfo region = const RegionInfo(code:"TR" ,name:"Turkey" ,prefix:90);
    return await PhoneNumberUtil().validate(phoneNumber, regionCode: region.code);

  }

  static Future<bool> smsSender(String message, List<String> recipents) async {

    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });

    print(_result);
    if (_result == "OK") {
      return true;
    } else {
      return false;
    }
  }

}

class SmsResultPackgage{

  SmsResultPackgage({required this.message,required this.result});

  String message;
  bool result;
}

