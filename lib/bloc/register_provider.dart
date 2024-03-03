import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../database/auth.dart';

// Olayları temsil eden sınıf
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String username;
  final String phoneNumber;
  var code;

  RegisterButtonPressed({required this.username, required this.phoneNumber,this.code= ""});

  @override
  List<Object> get props => [username, phoneNumber];
}

// Durumları temsil eden sınıf
abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {
   final String smsCode;
   final String userName;
   final String phonenumber;
  const RegisterSuccess({required this.smsCode, required this.userName, required this.phonenumber});
}
class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// BLoC sınıfı
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event, 
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
  
    try {
      print("RegisterButtonPressed");
      Authentication auth = Authentication();
   

      final smsResult = await auth.registerSendSMS(event.phoneNumber);
      print(smsResult.result);
      print(smsResult.message);
      print("------------------");
      if(smsResult.result){
        String code = smsResult.message;

        event.code = code;

        print("DENEME");
        print(state);
        emit(RegisterSuccess(smsCode: event.code,userName: event.username, phonenumber: event.phoneNumber));
        print("DENEME2");
        print(state);
      }
      else{
        emit(RegisterFailure(error: smsResult.message));
      }
      
      
    } catch (error) {
      emit(const RegisterFailure(error: 'Kayıt başarısız.'));
    }
  }
}