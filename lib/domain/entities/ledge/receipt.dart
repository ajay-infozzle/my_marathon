import 'package:json_annotation/json_annotation.dart';

part 'receipt.g.dart';

@JsonSerializable()
class Receipt {
  @JsonKey(name: 'acct_id')
  String? acctId;
  @JsonKey(name: 'receipt_no')
  String? receiptNo;
  @JsonKey(name: 'receipt_id')
  String? receiptId;
  @JsonKey(name: 'receipt_amount')
  String? receiptAmount;
  @JsonKey(name: 'milestone_id')
  String? milestoneId;
  @JsonKey(name: 'event_name')
  String? eventName;
  @JsonKey(name: 'receipt_status')
  String? receiptStatus;


  Receipt({this.acctId, this.receiptNo, this.receiptId, this.receiptAmount,
      this.milestoneId, this.eventName, this.receiptStatus});

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  @override
  String toString() => toJson().toString();
}
