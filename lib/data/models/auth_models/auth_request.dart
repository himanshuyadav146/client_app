
import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthRequest {
  String? email;
  String? password;

  AuthRequest({this.email, this.password});

  factory AuthRequest.fromJson(Map<String, dynamic> json) => _$AuthRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}