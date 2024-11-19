import 'package:json_annotation/json_annotation.dart';
import 'package:marathon/domain/entities/ledge/ledger_details.dart';

part 'ledger_details_response.g.dart';

@JsonSerializable()
class LedgerDetailsResponse {
  String? message;
  String? status;
  LedgerDetails? data;

  LedgerDetailsResponse({this.status, this.data, this.message});

  Map<String, dynamic> toJson() => _$LedgerDetailsResponseToJson(this);

  factory LedgerDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$LedgerDetailsResponseFromJson(json);

  @override
  String toString() => toJson().toString();
}
