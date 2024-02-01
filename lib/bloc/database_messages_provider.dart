import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MessageDatabaseEvent extends Equatable{
  const MessageDatabaseEvent();

  @override
  List<Object> get props => [];
}

class GetMessages extends MessageDatabaseEvent {

}

class SaveUserButtonPressed extends MessageDatabaseEvent {
  final String phoneNumber;
  final String username;

  const SaveUserButtonPressed({required this.phoneNumber, required this.username});

  @override
  List<Object> get props => [phoneNumber, username];
}


abstract class MessageDatabaseState extends Equatable {
  const MessageDatabaseState();

  @override
  List<Object> get props => [];
}

class MessageDatabseInitial extends MessageDatabaseState {}
class MessageDatabseLoading extends MessageDatabaseState {}
class MessageDatabseSuccess extends MessageDatabaseState {}

class MessageDatabseFailure extends MessageDatabaseState {
  final String error;

  const MessageDatabseFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// BLoC sınıfı
class MessageDatabaseBloc extends Bloc<MessageDatabaseEvent, MessageDatabaseState> {

  MessageDatabaseBloc() : super(MessageDatabseInitial()) {
    on<GetMessages>(_onGetMessages);
    on<SaveUserButtonPressed>(_onSaveUserButtonPressed);
  }

  Future<void> _onGetMessages(GetMessages event, Emitter<MessageDatabaseState> emit,) async {

    emit(MessageDatabseLoading());

    try {
 
      print("object");
      
      emit(MessageDatabseSuccess());
      
    } catch (error) {
      emit(const MessageDatabseFailure(error: 'Giriş başarısız.'));
    }
  }

  Future<void> _onSaveUserButtonPressed(SaveUserButtonPressed event, Emitter<MessageDatabaseState> emit,) async {

    emit(MessageDatabseLoading());

    try {
      
      print("Save Button Pressed");
      print(event.phoneNumber);
      print(event.username);  
      emit(MessageDatabseSuccess());
      
    } catch (error) {
      emit(const MessageDatabseFailure(error: 'Giriş başarısız.'));
    }
  }


}