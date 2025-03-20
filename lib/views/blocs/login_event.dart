part of 'login_bloc.dart';

abstract class LoginEvents extends Equatable {
  const LoginEvents();

  @override
  List<Object> get props => [];
}

class PhoneNoChange extends LoginEvents {
  const PhoneNoChange({required this.phoneNo});
  final String phoneNo;

  @override
  List<Object> get props => [phoneNo];
}

class EmailUnFocus extends LoginEvents {}

class PasswordChange extends LoginEvents {
  const PasswordChange({required this.password});
  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnFocus extends LoginEvents {}

class LoginSubmit extends LoginEvents {}
