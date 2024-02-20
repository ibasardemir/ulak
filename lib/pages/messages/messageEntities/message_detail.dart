import 'package:flutter/cupertino.dart';

class MessageDetail {
  String messageContent;
  String messageType;
  MessageDetail({required this.messageContent,required this.messageType});
}

List<MessageDetail> messages = [
    MessageDetail(messageContent: "Hello, Will", messageType: "receiver"),
    MessageDetail(messageContent: "How have you been?", messageType: "receiver"),
    MessageDetail(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    MessageDetail(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    MessageDetail(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];