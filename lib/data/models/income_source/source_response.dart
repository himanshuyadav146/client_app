
import 'package:client_app/data/models/income_source/sources.dart';
import 'package:json_annotation/json_annotation.dart';

import '../persional_info/persional_info_model.dart';

part 'source_response.g.dart';


@JsonSerializable(explicitToJson: true)
class SourceResponse {
  String? status;
  @JsonKey(name: 'data')
  List<PersionalInfoModel>? data;
  @JsonKey(name: 'source')
  List<Sources>? source;

  SourceResponse({this.status, this.data, this.source});

  factory SourceResponse.fromJson(Map<String, dynamic> json) =>
      _$SourceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SourceResponseToJson(this);
}


