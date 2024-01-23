import 'package:shared_preferences/shared_preferences.dart';
import "package:phone_number/phone_number.dart";

abstract class Database {
  Future<void> saveData(String tablename, String key, dynamic data);
  Future<dynamic> getData(String tablename, String key);
  Future<void> deleteData(String tablename, String key);
  bool syncDatabases();

}

class LocalDB extends Database{
  @override
  Future<void> deleteData(String tablename, String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future getData(String tablename, String key) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<void> saveData(String tablename, String key, data) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

  @override
  bool syncDatabases() {
    // TODO: implement syncDatabases
    throw UnimplementedError();
  }

}

class FirebaseDB extends Database{
  @override
  Future<void> deleteData(String tablename, String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future getData(String tablename, String key) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<void> saveData(String tablename, String key, data) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

  @override
  bool syncDatabases() {
    // TODO: implement syncDatabases
    throw UnimplementedError();
  }
  
}

//Currently designed for usual authentication, with completed tables data type requested can be changed
class Authentication {
  
  Future<bool> signIn(String phoneNumber) async {

    // * Doğukan buradaki kod ile telefon numarası valid mi diye test edebilirsin  
    RegionInfo region = const RegionInfo(code:"TR" ,name:"Turkey" ,prefix:90);
    bool isValid = await PhoneNumberUtil().validate(phoneNumber, regionCode: region.code);
    // *senin kodun buraya kadar
    
    if(isValid){
      SharedPreferences prefs = await SharedPreferences.getInstance();
    }

    
    //TODO: get data from user, save it to local database and also to shared preferences
    return true;

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
    String? username = prefs.getString('phoneNumber');

    if (username != null ) {
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

Future<bool> isvalid(String phoneNumber)async{
  RegionInfo region = const RegionInfo(code:"TR" ,name:"Turkey" ,prefix:90);
  return await PhoneNumberUtil().validate(phoneNumber, regionCode: region.code);

}
