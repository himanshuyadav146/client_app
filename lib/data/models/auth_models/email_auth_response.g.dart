// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailAuthResponse _$EmailAuthResponseFromJson(Map<String, dynamic> json) =>
    EmailAuthResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmailAuthResponseToJson(EmailAuthResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'token': instance.token,
      'user': instance.user?.toJson(),
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
