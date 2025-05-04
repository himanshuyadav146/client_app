import 'package:json_annotation/json_annotation.dart';

part 'persional_info_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PersionalInfoModel {
  String? firstName;
  String? middleName;
  String? lastName;
  String? panNumber;
  String? email;
  String? dob;

  PersionalInfoModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.panNumber,
    required this.email,
    required this.dob,
  });

  factory PersionalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PersionalInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersionalInfoModelToJson(this);
}
