// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      acctId: json['acct_id'] as String?,
      receiptNo: json['receipt_no'] as String?,
      receiptId: json['receipt_id'] as String?,
      receiptAmount: json['receipt_amount'] as String?,
      milestoneId: json['milestone_id'] as String?,
      eventName: json['event_name'] as String?,
      receiptStatus: json['receipt_status'] as String?,
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'acct_id': instance.acctId,
      'receipt_no': instance.receiptNo,
      'receipt_id': instance.receiptId,
      'receipt_amount': instance.receiptAmount,
      'milestone_id': instance.milestoneId,
      'event_name': instance.eventName,
      'receipt_status': instance.receiptStatus,
    };
