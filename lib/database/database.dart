


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


  void saveData(String tablename, User data);
  Future<List<User>>getData(String tablename);
  Future<bool> deleteData(String tablename, String key);
  Future<bool> syncDatabases(Database otherDatabase);
  Future<bool> openDB(String name);

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

  if(database==null){
    return false;
    }
  else{
    return database?.isOpen ??false;
  }
    
  }

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
  
}




