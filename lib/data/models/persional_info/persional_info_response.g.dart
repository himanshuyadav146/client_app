// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persional_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersionalInfoResponse _$PersionalInfoResponseFromJson(
        Map<String, dynamic> json) =>
    PersionalInfoResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      itrId: (json['itrId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PersionalInfoResponseToJson(
        PersionalInfoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'itrId': instance.itrId,
    };
