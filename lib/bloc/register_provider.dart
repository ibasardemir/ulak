import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../database/auth.dart';

// Olayları temsil eden sınıf
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final String code; //Kullanıcının gireceği sms kodu

  const LoginButtonPressed({required this.username, required this.password,this.code=""});

  @override
  List<Object> get props => [username, password];
}

// Durumları temsil eden sınıf
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// BLoC sınıfı
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event, 
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
  

    try {
      Authentication auth = Authentication();
   

      await Future.delayed(const Duration(seconds: 2));

      emit(LoginSuccess());
      print('Giriş başarılı. Kullanıcı adı: ${event.username}, Şifre: ${event.password}');

    } catch (error) {
      emit(const LoginFailure(error: 'Giriş başarısız.'));
    }
  }
}