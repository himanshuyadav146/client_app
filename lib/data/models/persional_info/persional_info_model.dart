import 'package:client_app/data/models/income_source/sources.dart';
import 'package:json_annotation/json_annotation.dart';

part 'persional_info_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PersionalInfoModel {
  final String financialYear;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String dob;
  final String pan;
  final String aadhaar;
  late final List<IncomeSource> source;

  PersionalInfoModel({
    required this.financialYear,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.pan,
    required this.aadhaar,
     required this.source,
  });

  factory PersionalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PersionalInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersionalInfoModelToJson(this);
}
