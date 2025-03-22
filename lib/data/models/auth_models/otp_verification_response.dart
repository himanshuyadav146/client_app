import 'package:json_annotation/json_annotation.dart';

part 'otp_verification_response.g.dart';

@JsonSerializable()
class OTPVerificationResponse {
  String? status;
  String? mobile;
  String? otp;
  String? message;
  Data? data;

  OTPVerificationResponse(
      {this.status, this.message, this.data, this.otp, this.mobile});

  factory OTPVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$OTPVerificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OTPVerificationResponseToJson(this);
}

@JsonSerializable()
class Data {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? mobile;
  String? password;
  String? userOTP;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.mobile,
      this.password,
      this.userOTP,
      this.createdAt,
      this.updatedAt});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
