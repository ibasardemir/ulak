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
  final String phoneNumber;
  var code; //Kullanıcının gireceği sms kodu

  LoginButtonPressed({required this.phoneNumber,this.code=""});

  @override
  List<Object> get props => [phoneNumber];
}

// Durumları temsil eden sınıf
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final String smsCode; 
   final String phonenumber;
  LoginSuccess({required this.smsCode, required this.phonenumber});
}
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
      final auth = Authentication();

      final smsResult = await auth.loginSendSms(event.phoneNumber);
      if(smsResult.result){
      event.code = smsResult.message;  

      emit(LoginSuccess(smsCode: event.code, phonenumber: event.phoneNumber));
      print(event.code);
      }
      else {
        emit(const LoginFailure(error: 'Giriş başarısız.'));
      }

    } catch (error) {
      emit(const LoginFailure(error: 'Giriş başarısız.'));
    }
  }
}