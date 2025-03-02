part of 'login_bloc.dart';

abstract class LoginEvents extends Equatable{
  const LoginEvents();

  @override
  List<Object> get props =>[];
}

class EmailChange extends LoginEvents{
  const EmailChange({required this.email});
  final String email;

  @override
  List<Object> get props =>[email];
}

class EmailUnFocus extends LoginEvents{}

class PasswordChange extends LoginEvents{
  const PasswordChange({required this.password});
  final String password;

  @override
  List<Object> get props =>[password];
}

class PasswordUnFocus extends LoginEvents{}
class LoginSubmit extends LoginEvents{}