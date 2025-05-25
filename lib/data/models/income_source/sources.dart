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
  @JsonKey(name: 'Id', includeIfNull: false)
  final String? id;

  @JsonKey(name: 'Name', includeIfNull: false)
  final String? name;

  IncomeSource({this.id, this.name});

  // Case-insensitive JSON parsing with fallbacks
  factory IncomeSource.fromJson(Map<String, dynamic> json) {
    // Handle case variations for 'id' and 'name'
    final dynamic idValue = json['Id'] ?? json['id'] ?? json['ID'];
    final dynamic nameValue = json['Name'] ?? json['name'] ?? json['NAME'];

    return IncomeSource(
      id: idValue?.toString(),
      name: nameValue?.toString(),
    );
  }

  Map<String, dynamic> toJson() => _$IncomeSourceToJson(this);

  // Preserved equality logic (unchanged)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is IncomeSource &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}