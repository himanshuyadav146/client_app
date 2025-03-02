part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.statusMessage = '',
    this.apiStatus = ApiStatus.initial,
  });

  final String email;
  final String password;
  final String statusMessage;
  final ApiStatus apiStatus;

  LoginState copyWith({
    String? email,
    String? password,
    String? statusMessage,
    ApiStatus? apiStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      statusMessage: statusMessage ?? this.statusMessage,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        statusMessage,
        apiStatus,
        apiStatus,
      ];
}
