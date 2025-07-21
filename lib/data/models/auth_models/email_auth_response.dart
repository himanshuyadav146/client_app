import 'package:json_annotation/json_annotation.dart';

part 'email_auth_response.g.dart';

@JsonSerializable(explicitToJson: true)
class EmailAuthResponse {
  String? status;
  String? message;
  String? token;
  UserData? user;

  EmailAuthResponse({this.status, this.message, this.token, this.user});

  factory EmailAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$EmailAuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmailAuthResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserData {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? created_at;
  String? updated_at;

  UserData({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.created_at,
    this.updated_at,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
} 