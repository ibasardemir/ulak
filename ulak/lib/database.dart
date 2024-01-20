import 'package:shared_preferences/shared_preferences.dart';

abstract class Database {
  Future<void> saveData(String key, dynamic data);
  Future<dynamic> getData(String key);
  Future<void> deleteData(String key);
}

class LocalUsersDB extends Database{
  @override
  Future<void> deleteData(String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future getData(String key) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<void> saveData(String key, data) {
    // TODO: implement saveData
    throw UnimplementedError();
  }
}

class LocalMessagesDB extends Database{
  @override
  Future<void> deleteData(String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future getData(String key) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<void> saveData(String key, data) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

}

class FirebaseUserDB extends Database{
  @override
  Future<void> deleteData(String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future getData(String key) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<void> saveData(String key, data) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

}

class FirebaseMessagesDB extends Database{
  @override
  Future<void> deleteData(String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future getData(String key) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<void> saveData(String key, data) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

}