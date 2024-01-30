import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MessageDatabaseEvent extends Equatable{
  const MessageDatabaseEvent();

  @override
  List<Object> get props => [];
}

class GetMessages extends MessageDatabaseEvent {

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
class LoginBloc extends Bloc<MessageDatabaseEvent, MessageDatabaseState> {
  LoginBloc() : super(MessageDatabseInitial()) {
    on<GetMessages>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    GetMessages event, 
    Emitter<MessageDatabaseState> emit,
  ) async {
    emit(MessageDatabseLoading());
  

    try {
      

      await Future.delayed(const Duration(seconds: 2));

      emit(MessageDatabseSuccess());
    } catch (error) {
      emit(const MessageDatabseFailure(error: 'Giriş başarısız.'));
    }
  }
}