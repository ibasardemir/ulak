import 'package:flutter/cupertino.dart';

class MessageDetail {
  String messageContent;
  String messageType;
  MessageDetail({required this.messageContent,required this.messageType});
}

class UserMessage {
  String phoneNumber;
  String? userName;
  bool isUserAvailable;
  String messageText;
  String time;
  UserMessage({required this.phoneNumber,required this.userName,required this.isUserAvailable, required this.messageText, required this.time});
}