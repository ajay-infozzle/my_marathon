import 'package:json_annotation/json_annotation.dart';

import '../../ledge/receipt.dart';

part 'milestone.g.dart';

@JsonSerializable()
class Milestone {
  @JsonKey(name: 'acct_id')
  String? acctId;
  @JsonKey(name: 'sr_no')
  String? srNo;
  @JsonKey(name: 'milestone_id')
  String? milestoneId;
  @JsonKey(name: 'event_name')
  String? eventName;
  String? status;
  @JsonKey(name: 'due_date')
  String? dueDate;
  String? amount;
  @JsonKey(name: 'receipt_ids')
  String? receiptIds;
  @JsonKey(name: 'receipt_dt')
  String? receiptDt;
  @JsonKey(name: 'recv_amt')
  String? recvAmt;
  @JsonKey(name: 'outstanding_amt')
  String? outstandingAmt;
  @JsonKey(name: 'intrest_recv_amount')
  String? intrestRecvAmount;
  List<Receipt>? receipts;
  @JsonKey(name: 'apartment_cost')
  String? apartmentCost;
  String? taxes;
  @JsonKey(name: 'other_costs')
  String? otherCosts;

  Milestone(
      {this.acctId,
      this.outstandingAmt,
      this.eventName,
      this.amount,
      this.status,
      this.dueDate,
      this.intrestRecvAmount,
      this.milestoneId,
      this.receiptDt,
      this.receiptIds,
      this.recvAmt,
      this.srNo,
      this.taxes,
      this.apartmentCost,
      this.otherCosts,
      this.receipts});

  Map<String, dynamic> toJson() => _$MilestoneToJson(this);

  factory Milestone.fromJson(Map<String, dynamic> json) =>
      _$MilestoneFromJson(json);

  @override
  String toString() => toJson().toString();
}
