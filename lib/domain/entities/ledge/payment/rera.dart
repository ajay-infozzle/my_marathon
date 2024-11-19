import 'package:json_annotation/json_annotation.dart';

import 'bank_details.dart';

part 'rera.g.dart';

@JsonSerializable()
class Rera {


  String? building;
  String? project;
  @JsonKey(name: 'rera_reg_no')
  String? reraRegNo;
  @JsonKey(name: 'bank_details')
  BankDetails? bankDetails;


  Rera({this.building, this.project, this.reraRegNo, this.bankDetails});

  Map<String, dynamic> toJson() => _$ReraToJson(this);

  factory Rera.fromJson(Map<String, dynamic> json) =>
      _$ReraFromJson(json);

  @override
  String toString() => toJson().toString();
}
