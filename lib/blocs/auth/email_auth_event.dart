part of 'email_auth_bloc.dart';

abstract class EmailAuthEvent extends Equatable {
  const EmailAuthEvent();

  @override
  List<Object> get props => [];
}

class EmailChange extends EmailAuthEvent {
  final String email;

  const EmailChange({required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChange extends EmailAuthEvent {
  final String password;

  const PasswordChange({required this.password});

  @override
  List<Object> get props => [password];
}

class NameChange extends EmailAuthEvent {
  final String name;

  const NameChange({required this.name});

  @override
  List<Object> get props => [name];
}

class EmailLoginSubmit extends EmailAuthEvent {}

class EmailSignupSubmit extends EmailAuthEvent {}

class ForgotPasswordSubmit extends EmailAuthEvent {} 