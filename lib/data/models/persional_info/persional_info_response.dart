import 'package:json_annotation/json_annotation.dart';

part 'persional_info_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PersionalInfoResponse {
  String? status;
  String? message;
  int? itrId;

  PersionalInfoResponse({this.status, this.message, this.itrId});

  factory PersionalInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$PersionalInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersionalInfoResponseToJson(this);
}
