import 'package:json_annotation/json_annotation.dart';

import 'my_account_data.dart';

part 'my_account_response.g.dart';

@JsonSerializable(createFactory: true)
class MyAccountResponse{
  MyAccountData? data;
  String? status;

  MyAccountResponse({this.data, this.status});

  Map<String,dynamic> toJson() => _$MyAccountResponseToJson(this);

  factory MyAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$MyAccountResponseFromJson(json);

  @override
  String toString() => toJson().toString();
}
