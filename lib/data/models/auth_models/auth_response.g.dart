// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      receivedData: json['received_data'] == null
          ? null
          : ReceivedData.fromJson(
              json['received_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'received_data': instance.receivedData?.toJson(),
    };

ReceivedData _$ReceivedDataFromJson(Map<String, dynamic> json) => ReceivedData(
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$ReceivedDataToJson(ReceivedData instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
    };
