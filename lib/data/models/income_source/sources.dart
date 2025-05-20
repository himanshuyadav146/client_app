import 'package:json_annotation/json_annotation.dart';
part 'sources.g.dart';


@JsonSerializable(explicitToJson: true)
class Sources {
  String? status;
  @JsonKey(name: 'data')
  List<IncomeSource>? data;

  Sources({this.status, this.data});

  factory Sources.fromJson(Map<String, dynamic> json) =>
      _$SourcesFromJson(json);
  Map<String, dynamic> toJson() => _$SourcesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class IncomeSource {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'Name')
  String? name;
  @JsonKey(name: 'CreatedAt')
  String? createdAt;
  @JsonKey(name: 'UpdatedAt')
  String? updatedAt;

  IncomeSource({this.id, this.name, this.createdAt, this.updatedAt});

  factory IncomeSource.fromJson(Map<String, dynamic> json) =>
      _$IncomeSourceFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeSourceToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is IncomeSource && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}