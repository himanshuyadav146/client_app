// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sources.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sources _$SourcesFromJson(Map<String, dynamic> json) => Sources(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => IncomeSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      sourceId: json['sourceId'] as String?,
      sourceName: json['sourceName'] as String?,
      isSelect: json['isSelect'] as String?,
      itrId: json['itrId'] as String?,
    );

Map<String, dynamic> _$SourcesToJson(Sources instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'sourceId': instance.sourceId,
      'sourceName': instance.sourceName,
      'isSelect': instance.isSelect,
      'itrId': instance.itrId,
    };

IncomeSource _$IncomeSourceFromJson(Map<String, dynamic> json) => IncomeSource(
      id: json['Id'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$IncomeSourceToJson(IncomeSource instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.name case final value?) 'Name': value,
    };
