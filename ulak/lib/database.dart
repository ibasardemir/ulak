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