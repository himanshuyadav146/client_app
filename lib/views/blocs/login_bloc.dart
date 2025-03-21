import 'package:bloc/bloc.dart';
import 'package:client_app/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import '../../domain/repositories/auth/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<PhoneNoChange>(_onEmailChanged);
    on<LoginSubmit>(_onLoginSubmit);
    on<OTPChange>(_onOTPChanged);
    on<VerifyOTP>(_onVerifyOTP);
  }

  void _onEmailChanged(PhoneNoChange event, Emitter<LoginState> emit) {
    emit(state.copyWith(phoneNo: event.phoneNo));
  }

  void _onOTPChanged(OTPChange event, Emitter<LoginState> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  // void _onPasswordChanged(PasswordChange event, Emitter<LoginState> emit) {
  //   emit(state.copyWith(password: event.password));
  // }

  Future<void> _onLoginSubmit(
      LoginSubmit event, Emitter<LoginState> emit) async {

    final Map<String, dynamic> data = {
      "mobile": state.phoneNo,
    };
    emit(
      state.copyWith(
        apiStatus: ApiStatus.loading,
      ),
    );
    await authRepository.login(data).then((onValue) {
      if (onValue.data == null) {
        emit(state.copyWith(
            statusMessage: 'Something went wrong', apiStatus: ApiStatus.error));
        return;
      }
      emit(state.copyWith(
          statusMessage: 'Success', apiStatus: ApiStatus.success));
    }).catchError((onError) {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    });
  }

  Future<void> _onVerifyOTP(
      VerifyOTP event, Emitter<LoginState> emit) async {

    final Map<String, dynamic> data = {
      "mobile": state.phoneNo,
      "otp": state.otp
    };
    emit(
      state.copyWith(
        apiStatus: ApiStatus.loading,
      ),
    );
    await authRepository.otpVerify(data).then((onValue) {
      if (onValue.data == null) {
        emit(state.copyWith(
            statusMessage: 'Something went wrong', apiStatus: ApiStatus.error));
        return;
      }
      emit(state.copyWith(
          statusMessage: 'Success', apiStatus: ApiStatus.success));
    }).catchError((onError) {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    });
  }
}
