import 'package:flutter/cupertino.dart';

class MessageDetail {
  String messageContent;
  String messageType;
  MessageDetail({required this.messageContent,required this.messageType});
}

class UserMessage {
  String phoneNumber;
  String userName;
  UserMessage({required this.phoneNumber,required this.userName});
}