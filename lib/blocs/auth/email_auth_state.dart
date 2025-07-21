part of 'email_auth_bloc.dart';

class EmailAuthState extends Equatable {
  final String email;
  final String password;
  final String name;
  final ApiStatus apiStatus;
  final String statusMessage;

  const EmailAuthState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.apiStatus = ApiStatus.initial,
    this.statusMessage = '',
  });

  EmailAuthState copyWith({
    String? email,
    String? password,
    String? name,
    ApiStatus? apiStatus,
    String? statusMessage,
  }) {
    return EmailAuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      apiStatus: apiStatus ?? this.apiStatus,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [email, password, name, apiStatus, statusMessage];
} 