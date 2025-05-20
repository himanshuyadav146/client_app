// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persional_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersionalInfoModel _$PersionalInfoModelFromJson(Map<String, dynamic> json) =>
    PersionalInfoModel(
      financialYear: json['financialYear'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      dob: json['dob'] as String,
      pan: json['pan'] as String,
      aadhaar: json['aadhaar'] as String,
      source: (json['source'] as List<dynamic>)
          .map((e) => IncomeSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PersionalInfoModelToJson(PersionalInfoModel instance) =>
    <String, dynamic>{
      'financialYear': instance.financialYear,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'email': instance.email,
      'dob': instance.dob,
      'pan': instance.pan,
      'aadhaar': instance.aadhaar,
      'source': instance.source.map((e) => e.toJson()).toList(),
    };
