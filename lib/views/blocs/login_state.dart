part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.phoneNo = '',
    this.otp = '',
    this.statusMessage = '',
    this.apiStatus = ApiStatus.initial,
  });

  final String phoneNo;
  final String otp;
  final String statusMessage;
  final ApiStatus apiStatus;

  LoginState copyWith({
    String? phoneNo,
    String? otp,
    String? statusMessage,
    ApiStatus? apiStatus,
  }) {
    return LoginState(
      phoneNo: phoneNo ?? this.phoneNo,
      otp: otp ?? this.otp,
      statusMessage: statusMessage ?? this.statusMessage,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }

  @override
  List<Object?> get props => [
        phoneNo,
        otp,
        statusMessage,
        apiStatus,
        apiStatus,
      ];
}
