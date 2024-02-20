import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulak/database/database.dart';
import 'package:ulak/pages/messages/messageEntities/message_detail.dart';

abstract class MessagesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SentMessages extends MessagesEvent {
  final String messageContent;

  SentMessages({required this.messageContent});

  @override
  List<Object?> get props => [messageContent];
}

abstract class MessagesState extends Equatable {
  final List<MessageDetail> messages;

  const MessagesState({this.messages = const []});

  @override
  List<Object?> get props => [messages];
}

class MessagesInitial extends MessagesState {
  const MessagesInitial();
}

class MessagesUpdated extends MessagesState {
  const MessagesUpdated(List<MessageDetail> messages) : super(messages: messages);
}

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(const MessagesInitial()) {
    on<SentMessages>(_onSentMessages);
  }

  void _onSentMessages(SentMessages event, Emitter<MessagesState> emit)async {
    print("sdfsdfasdfasdfasdfdasf");
    final currentState = state;
    FirebaseDB firebaseDB = FirebaseDB();
    LocalDB localDB = LocalDB();
    SharedPreferences prefs =await SharedPreferences.getInstance();

    //TODO: Change the reciever to the actual reciever
    Message message = Message(sender:prefs.getString("phoneNumber"),reciever: "admin",message:event.messageContent);

    firebaseDB.saveMessage(message);
    localDB.saveMessage(message);

    final newList = List<MessageDetail>.from(currentState.messages)
      ..add(MessageDetail(messageContent: event.messageContent, messageType: "receiver"));
    emit(MessagesUpdated(newList));
  }
}