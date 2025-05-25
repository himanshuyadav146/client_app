// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persional_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersionalInfoModel _$PersionalInfoModelFromJson(Map<String, dynamic> json) =>
    PersionalInfoModel(
      itrId: json['itrId'] as String?,
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      panNumber: json['panNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      isFillSevProv: json['isFillSevProv'] as String?,
      isDeposited: json['isDeposited'] as String?,
      isExpForeign: json['isExpForeign'] as String?,
      isExpElectricity: json['isExpElectricity'] as String?,
      financialYear: json['financialYear'] as String?,
      source: (json['source'] as List<dynamic>?)
          ?.map((e) => IncomeSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PersionalInfoModelToJson(PersionalInfoModel instance) =>
    <String, dynamic>{
      'itrId': instance.itrId,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'mobile': instance.mobile,
      'email': instance.email,
      'panNumber': instance.panNumber,
      'dateOfBirth': instance.dateOfBirth,
      'isFillSevProv': instance.isFillSevProv,
      'isDeposited': instance.isDeposited,
      'isExpForeign': instance.isExpForeign,
      'isExpElectricity': instance.isExpElectricity,
      'financialYear': instance.financialYear,
      'source': instance.source?.map((e) => e.toJson()).toList(),
    };
