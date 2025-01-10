import 'package:json_annotation/json_annotation.dart';

import '../aparments/apartment_details/apartment_details.dart';
import '../aparments/apartment_details/milestone.dart';


part 'ledger_details.g.dart';

@JsonSerializable(createFactory: true)
class LedgerDetails {
  @JsonKey(name: 'apt_id')
  int? aptId;
  List<Milestone>? milestones;

  ApartmentDetails? details;

  dynamic demandLetterRouteData;

  String? totalOutstanding;

  LedgerDetails({
    this.aptId,
    this.milestones,
    this.totalOutstanding,
    this.details,
    this.demandLetterRouteData,
  });

  Map<String, dynamic> toJson() => _$LedgerDetailsToJson(this);

  factory LedgerDetails.fromJson(Map<String, dynamic> json) =>
      _$LedgerDetailsFromJson(json);

  @override
  String toString() => toJson().toString();
}
