import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ulak/bloc/database_messages_provider.dart';
import 'package:ulak/network/flutternearby.dart';


class Message{

    Message({required this.sender, required this.reciever, required this.message, required this.status,this.sentTime});

    final String? sender;
    final String? reciever;
    final String? message;
    final bool? status;
    DateTime? sentTime;
    String? id;

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'reciever': reciever,
      'message': message,
      'status': status,
    };
  }

  void generateID(){
    id = sender!+reciever!+sentTime!.toString();
  }
}


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

  DatabaseUtility(){}

  void saveUser(User data);
  void saveMessage(Message data);
  Future<List<User>>getUsers();
  Future<List<Message>> getMessages();
  Future<bool> deleteData(String tablename, String key);
  Future<bool> syncDatabases(Database otherDatabase);
  Future<bool> openDB(String name);
  void deleteDB(String name);
}

class LocalDB extends DatabaseUtility{
  Database? database;
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
  Future<List<User>> getUsers() async {
    final List<Map<String, dynamic>> maps = await database?.query("users") ?? [];


    return List.generate(maps.length, (i) {
    return User(
      phoneNumber: maps[i]['phoneNumber'] as String,
      username: maps[i]['username'] as String,
    
    );
  });
}
  
@override
  Future<List<Message>> getMessages() async {
    print("DEBUG");
    final List<Map<String, dynamic>> maps = await database?.query("messages") ?? [];
    
    print(maps);
    List<Message> messages = [];
    for (var map in maps) {
      Message message=Message(
        sender: map['sender'] as String,
        reciever: map['reciever'] as String,
        message: map['message'] as String,
        status: map['status'] as int==1?true:false,
        sentTime: DateTime.parse(map['sentTime'] as String), 
      );
      message.generateID();
      messages.add(message);
    }
 

    return messages;

  
  ;
}

  @override
  void saveUser(User data) async{
    await database?.insert(
      "users",
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  void saveMessage(Message data) async{
    await database?.insert(
      "messages",
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
                            onCreate: (db, version) async {
                                db.execute(
                                "CREATE TABLE users(phoneNumber TEXT PRIMARY KEY, username TEXT)"
                                );

                                db.execute('''CREATE TABLE messages(
                                  sender TEXT,
                                  reciever TEXT,
                                  message TEXT,
                                  status BOOLEAN,
                                  sentTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                  PRIMARY KEY (sender,reciever,sentTime)
                                );''');
                            },

                            version: 1,
);


  if(database==null){
    return false;
    }
  else{
    print(database);
    return database?.isOpen ??false;
  }
    
  }
  
  @override
  void deleteDB(String name) async=> databaseFactory.deleteDatabase(join(await getDatabasesPath(), '$name.db'));

}

class FirebaseDB extends DatabaseUtility{
  @override
  void deleteDB(String name) {
    // TODO: implement deleteDB
  }

  @override
  Future<bool> deleteData(String tablename, String key) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<Message>> getMessages() {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<bool> openDB(String name) {
    // TODO: implement openDB
    throw UnimplementedError();
  }

  @override
  void saveMessage(Message data) {
    // TODO: implement saveMessage
  }

  @override
  void saveUser(User data) {
    // TODO: implement saveUser
  }

  @override
  Future<bool> syncDatabases(Database otherDatabase) {
    // TODO: implement syncDatabases
    throw UnimplementedError();
  }
  
  
}




