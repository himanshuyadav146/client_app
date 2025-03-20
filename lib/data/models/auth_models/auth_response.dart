import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthResponse {
  String? token;
  int? success;
  String? data;

  AuthResponse({this.token,this.success,this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
