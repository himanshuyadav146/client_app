// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persional_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersionalInfoModel _$PersionalInfoModelFromJson(Map<String, dynamic> json) =>
    PersionalInfoModel(
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      panNumber: json['panNumber'] as String?,
      email: json['email'] as String?,
      dob: json['dob'] as String?,
    );

Map<String, dynamic> _$PersionalInfoModelToJson(PersionalInfoModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'panNumber': instance.panNumber,
      'email': instance.email,
      'dob': instance.dob,
    };
