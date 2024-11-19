import 'package:json_annotation/json_annotation.dart';

part 'bank_details.g.dart';

@JsonSerializable()
class BankDetails {


  String? name;
  String? address;
  String? branch;
  @JsonKey(name: 'ifsc_code')
  String? ifscCode;
  @JsonKey(name: 'acc_name')
  String? accName;
  @JsonKey(name: 'ac_no')
  String? acNo;


  BankDetails({this.name, this.address, this.branch, this.ifscCode, this.accName,
      this.acNo});

  Map<String, dynamic> toJson() => _$BankDetailsToJson(this);

  factory BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);

  @override
  String toString() => toJson().toString();
}
