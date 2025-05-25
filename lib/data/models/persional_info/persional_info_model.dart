import 'package:client_app/data/models/income_source/sources.dart';
import 'package:json_annotation/json_annotation.dart';

part 'persional_info_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PersionalInfoModel {
  String? itrId;
  String? userId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobile;
  String? email;
  String? panNumber;
  String? dateOfBirth;
  String? isFillSevProv;
  String? isDeposited;
  String? isExpForeign;
  String? isExpElectricity;
  String? financialYear;
  List<IncomeSource>? source;

  PersionalInfoModel({this.itrId,
    this.userId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.mobile,
    this.email,
    this.panNumber,
    this.dateOfBirth,
    this.isFillSevProv,
    this.isDeposited,
    this.isExpForeign,
    this.isExpElectricity,
    this.financialYear,
    this.source});

  factory PersionalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PersionalInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersionalInfoModelToJson(this);
}
