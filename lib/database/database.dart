import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ulak/network/flutternearby.dart';

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


  void saveData(String tablename, User data);
  Future<List<User>>getData(String tablename);
  Future<bool> deleteData(String tablename, String key);
  Future<bool> syncDatabases(Database otherDatabase);
  Future<bool> openDB(String name);
  void deleteDB(String name);
}

class LocalDB extends DatabaseUtility{
  
  static final LocalDB _instance = LocalDB._internal();
  
  //private constructor
  LocalDB._internal();

  factory LocalDB() {
    return _instance;
  }

  @override
  Future<bool>  deleteData(String tablename, String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getData(String tablename) async {
    final List<Map<String, dynamic>> maps = await database?.query(tablename) ?? [];

    return List.generate(maps.length, (i) {
    return User(
      phoneNumber: maps[i]['phoneNumber'] as String,
      username: maps[i]['username'] as String,
    
    );
  });
}
  

  @override
  void saveData(String tablename,User data) async{
    await database?.insert(
      tablename,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<bool>  syncDatabases(Database otherDatabase) {
    // TODO: implement syncDatabases
    throw UnimplementedError();
  }
  
  @override
  Future<bool> openDB(String name) async {
  print(join(await getDatabasesPath(), '$name.db'));
  
  database =await openDatabase(
                            join(await getDatabasesPath(), '$name.db'),
                            onCreate: (db, version) {
                                return db.execute(
                                'CREATE TABLE users(phoneNumber TEXT PRIMARY KEY, username TEXT)',
                                );
                            },

                            version: 1,
);

  if(database==null){
    return false;
    }
  else{
    return database?.isOpen ??false;
  }
    
  }
  
  @override
  void deleteDB(String name) async=> databaseFactory.deleteDatabase(join(await getDatabasesPath(), '$name.db'));

}

class FirebaseDB extends DatabaseUtility{
  @override
  Future<bool> deleteData(String tablename, String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getData(String tablename) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<bool> saveData(String tablename, User data) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

  @override
  Future<bool> syncDatabases(Database otherDatabase) {
    // TODO: implement syncDatabases
    throw UnimplementedError();
  }
  
  @override
  Future<bool> openDB(String name) {
    // TODO: implement openDatabase
    throw UnimplementedError();
  }
  
  @override
  void deleteDB(String name) {
    // TODO: implement deleteDB
    throw UnimplementedError();
  }
  
}




