import 'package:shared_preferences/shared_preferences.dart';

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
  
  Future<bool> signIn(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //TODO: get data from user, save it to local database and also to shared preferences
    return true;

  }


  Future<bool> login(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
    return true;
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('password');
    return true;
  }

  Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');
    if (username != null && password != null) {
      return true;
    } else {
      return false;
    }
  }
}