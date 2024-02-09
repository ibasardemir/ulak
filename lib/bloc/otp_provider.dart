import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulak/bloc/register_provider.dart';
import '../database/auth.dart';

// Olayları temsil eden sınıf
abstract class OTPEvent extends Equatable {
  const OTPEvent();

  @override
  List<Object> get props => [];
}

class OTPControl extends OTPEvent {
  final String code; 

  const OTPControl({required this.code});

  @override
  List<Object> get props => [code];
}

// Durumları temsil eden sınıf
abstract class OTPState extends Equatable {
  const OTPState();

  @override
  List<Object> get props => [];
}

class OTPInitial extends OTPState {}
class OTPLoading extends OTPState {}
class OTPSuccess extends OTPState {}
class OTPFailure extends OTPState {
  final String error;

  const OTPFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// BLoC sınıfı
class OTPBloc extends Bloc<OTPEvent, OTPState> {
  final RegisterBloc registerBloc;

  OTPBloc({required this.registerBloc}) : super(OTPInitial()) {
    on<OTPControl>(_onOTPControl);
  }

  Future<void> _onOTPControl(
    OTPControl event, 
    Emitter<OTPState> emit,
  ) async {
    emit(OTPLoading());
    final currentState = registerBloc.state;
    try {
    print(currentState);

    if (currentState is RegisterSuccess) {
      String smsCode = currentState.smsCode;

      if (smsCode == event.code) {
        print("fsdfasdfasdfasdfasdfasdfs");

        emit(OTPSuccess());
      } else {
        emit(OTPFailure(error: 'Doğrulama kodu yanlış.'));
      }
    } else {
      emit(OTPFailure(error: 'Kayıt işlemi tamamlanmadı.'));
    }
  } catch (error) {
    emit(OTPFailure(error: error.toString()));
  }
  }
}