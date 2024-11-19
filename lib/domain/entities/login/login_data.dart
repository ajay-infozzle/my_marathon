import 'package:json_annotation/json_annotation.dart';

part 'login_data.g.dart';

@JsonSerializable()
class Data {



  @JsonKey(name: 'user_id')
  int? userId;
  String? name;
  String? email;
  String? mobile;
  int? otp;
  bool? verified;
  @JsonKey(name: 'cust_id')
  int? custId;

  Data({this.name,this.email, this.userId,this.custId,this.mobile,this.verified, this.otp});

  Map<String, dynamic> toJson() => _$DataToJson(this);

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  @override
  String toString() => toJson().toString();
}
