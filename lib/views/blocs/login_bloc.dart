import 'package:bloc/bloc.dart';
import 'package:client_app/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import '../../domain/repositories/auth/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<EmailChange>(_onEmailChanged);
    on<PasswordChange>(_onPasswordChanged);
    on<LoginSubmit>(_onLoginSubmit);
  }

  void _onEmailChanged(EmailChange event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChange event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginSubmit(
      LoginSubmit event, Emitter<LoginState> emit) async {
    final data = {
      'email': state.email,
      'password': state.password,
    };
    // final data = {
    //   'email': 'eve.holt@reqres.in',
    //   'password': 'cityslicka',
    // };
    emit(
      state.copyWith(
        apiStatus: ApiStatus.loading,
      ),
    );
    await authRepository.login(data).then((onValue) {
      if (onValue.token == null) {
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
