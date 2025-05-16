import 'package:json_annotation/json_annotation.dart';
part 'sources.g.dart';


@JsonSerializable(explicitToJson: true)
class Sources {
  String? status;
  List<Data>? data;

  Sources({this.status, this.data});

  factory Sources.fromJson(Map<String, dynamic> json) =>
      _$SourcesFromJson(json);
  Map<String, dynamic> toJson() => _$SourcesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Data {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'Name')
  String? name;
  @JsonKey(name: 'CreatedAt')
  String? createdAt;
  @JsonKey(name: 'UpdatedAt')
  String? updatedAt;

  Data({this.id, this.name, this.createdAt, this.updatedAt});

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Data && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}