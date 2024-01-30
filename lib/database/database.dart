
import 'dart:isolate';

import 'package:shared_preferences/shared_preferences.dart';

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

  DatabaseUtility(){database=null;}

  Database? database;


  Future<bool> saveData(String tablename, String key, dynamic data);
  Future<dynamic> getData(String tablename, String key);
  Future<bool> deleteData(String tablename, String key);
  Future<bool> syncDatabases(Database otherDatabase);
  Future<bool> openDB(String path);

}

class LocalDB extends DatabaseUtility{
  

  LocalDB(){}

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
  Future<bool> openDB(String name) async {
  database =await openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), '$name.db'),
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




