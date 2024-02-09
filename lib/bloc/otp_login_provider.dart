import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulak/bloc/login_provider.dart';
import 'package:ulak/bloc/register_provider.dart';
import '../database/auth.dart';

// Olayları temsil eden sınıf
abstract class OTPLoginEvent extends Equatable {
  const OTPLoginEvent();

  @override
  List<Object> get props => [];
}

class OTPLoginControl extends OTPLoginEvent {
  final String code; 

  const OTPLoginControl({required this.code});

  @override
  List<Object> get props => [code];
}

// Durumları temsil eden sınıf
abstract class OTPLoginState extends Equatable {
  const OTPLoginState();

  @override
  List<Object> get props => [];
}

class OTPLoginInitial extends OTPLoginState {}
class OTPLoginLoading extends OTPLoginState {}
class OTPLoginSuccess extends OTPLoginState {}
class OTPLoginFailure extends OTPLoginState {
  final String error;

  const OTPLoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// BLoC sınıfı
class OTPLoginBloc extends Bloc<OTPLoginEvent, OTPLoginState> {
  final LoginBloc loginBloc;

  OTPLoginBloc({required this.loginBloc}) : super(OTPLoginInitial()) {
    on<OTPLoginControl>(_onOTPLoginControl);
  }

  Future<void> _onOTPLoginControl(
    OTPLoginControl event, 
    Emitter<OTPLoginState> emit,
  ) async {
    emit(OTPLoginLoading());
    final currentState = loginBloc.state;
    try {
    print(currentState);
    if (currentState is LoginSuccess) {

      String smsCode = currentState.smsCode;
      
      final verifyResult= true;
      print(verifyResult);
      print(smsCode);
      print(event.code);
      if (verifyResult) {
        print("Kayıt işlemi başarılı.");
        emit(OTPLoginSuccess());
      }
    } else {
      emit(OTPLoginFailure(error: 'Kayıt işlemi tamamlanmadı.'));
    }
  } catch (error) {
    emit(OTPLoginFailure(error: error.toString()));
  }
  }
}