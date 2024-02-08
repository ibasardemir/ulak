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
  final String code; //Kullanıcının gireceği sms kodu

  const RegisterButtonPressed({required this.username, required this.phoneNumber,this.code=""});

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
class RegisterSuccess extends RegisterState {}
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
      await Future.delayed(const Duration(seconds: 2));

      if (!smsResult.result) {
        emit(RegisterFailure(error: smsResult.message));
        return;
      }
      else{
        final registerResult=await auth.registerVerifySMS(smsResult.message, event.code, event.phoneNumber, event.username);

        if(registerResult){
          emit(RegisterSuccess());
        }
        else{
          emit(const RegisterFailure(error: 'Kayıt başarısız.'));
        }
      }

    

      


    } catch (error) {
      emit(const RegisterFailure(error: 'Kayıt başarısız.'));
    }
  }
}