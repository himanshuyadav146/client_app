// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPVerificationResponse _$OTPVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    OTPVerificationResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      otp: json['otp'] as String?,
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$OTPVerificationResponseToJson(
        OTPVerificationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'mobile': instance.mobile,
      'otp': instance.otp,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      password: json['password'] as String?,
      userOTP: json['userOTP'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'email': instance.email,
      'mobile': instance.mobile,
      'password': instance.password,
      'userOTP': instance.userOTP,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
