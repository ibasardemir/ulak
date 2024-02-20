import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulak/pages/messages/messageEntities/message_detail.dart';

abstract class MessagesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SentMessages extends MessagesEvent {
  final String messageContent;
  final String phoneNumber;

  SentMessages({required this.messageContent,required this.phoneNumber});

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

  void _onSentMessages(SentMessages event, Emitter<MessagesState> emit) {
    final currentState = state;
    final newList = List<MessageDetail>.from(currentState.messages)
      ..add(MessageDetail(messageContent: event.messageContent, messageType: "receiver"));
    emit(MessagesUpdated(newList));
  }
}