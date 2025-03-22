import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthResponse {
  String? status;
  String? message;

  @JsonKey(name: 'received_data')
  ReceivedData? receivedData;

  AuthResponse({this.status, this.message, this.receivedData});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReceivedData {
  String? mobile;

  ReceivedData({this.mobile});

  factory ReceivedData.fromJson(Map<String, dynamic> json) =>
      _$ReceivedDataFromJson(json);
  Map<String, dynamic> toJson() => _$ReceivedDataToJson(this);
}
