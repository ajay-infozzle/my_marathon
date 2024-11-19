import 'package:json_annotation/json_annotation.dart';
import 'package:marathon/domain/entities/ledge/payment/rera.dart';

import 'original_data.dart';

part 'my_account_data.g.dart';

@JsonSerializable()
class MyAccountData {
  @JsonKey(name: 'original')
  OriginalData? original;
  @JsonKey(name: 'exception')
  String? exception;

  MyAccountData({this.exception,this.original});

  Map<String, dynamic> toJson() => _$MyAccountDataToJson(this);

  factory MyAccountData.fromJson(Map<String, dynamic> json) =>
      _$MyAccountDataFromJson(json);

  @override
  String toString() => toJson().toString();
}
