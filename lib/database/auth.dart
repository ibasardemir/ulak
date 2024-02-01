//Currently designed for usual authentication, with completed tables data type requested can be changed
import 'database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phone_number/phone_number.dart';

class Authentication {
  
  LocalDB localDB = LocalDB();
  FirebaseDB firebaseDB = FirebaseDB();

  //Takes phone number as argument and sends sms to that number with a random 6 digit number
  //returns true if sms is sent successfully else returns false


  //If entered code entered by user is equal to the code sended by signInSmsSender function save user to databases and shared preferences
  //If save is successful returns true else returns false


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

class SmsResultPackgage{

  SmsResultPackgage({this.message, this.result});

  String? message;
  bool? result;
}

