import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulak/database/database.dart';
import 'package:ulak/pages/messages/messageEntities/message_detail.dart';

abstract class UsersMessagesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUser extends UsersMessagesEvent {
  final String phoneNumber;

  GetUser({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

abstract class UserMessagesState extends Equatable {
  final List<UserMessage> userMessages;

  const UserMessagesState({this.userMessages = const []});

  @override
  List<Object?> get props => [userMessages];
}

class UserMessagesInitial extends UserMessagesState {
  const UserMessagesInitial();
}

class UserMessagesUpdated extends UserMessagesState {
  const UserMessagesUpdated(List<UserMessage> messages) : super(userMessages: messages);
}

class UserMessagesBloc extends Bloc<UsersMessagesEvent, UserMessagesState> {
  UserMessagesBloc() : super(const UserMessagesInitial()) {
    on<GetUser>(_onGetUser);
  }

  void _onGetUser(GetUser event, Emitter<UserMessagesState> emit)async {
    final currentState = state;
    final userName = "Zeynebim";
    LocalDB localDB=LocalDB();
    localDB.syncDatabases(FirebaseDB());
    List<User> users=await localDB.getUsers();
 
    for (User user in users){
      print(user.phoneNumber);
    }
    print(event.phoneNumber);
    final newList = List<UserMessage>.from(currentState.userMessages)
      ..add(UserMessage(phoneNumber: event.phoneNumber,userName: userName));
    emit(UserMessagesUpdated(newList));
  }
  
}
//annen

