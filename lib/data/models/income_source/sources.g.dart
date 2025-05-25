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
    );

Map<String, dynamic> _$SourcesToJson(Sources instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.map((e) => e.toJson()).toList(),
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
