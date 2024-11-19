// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Milestone _$MilestoneFromJson(Map<String, dynamic> json) => Milestone(
      acctId: json['acct_id'] as String?,
      outstandingAmt: json['outstanding_amt'] as String?,
      eventName: json['event_name'] as String?,
      amount: json['amount'] as String?,
      status: json['status'] as String?,
      dueDate: json['due_date'] as String?,
      intrestRecvAmount: json['intrest_recv_amount'] as String?,
      milestoneId: json['milestone_id'] as String?,
      receiptDt: json['receipt_dt'] as String?,
      receiptIds: json['receipt_ids'] as String?,
      recvAmt: json['recv_amt'] as String?,
      srNo: json['sr_no'] as String?,
      taxes: json['taxes'] as String?,
      apartmentCost: json['apartment_cost'] as String?,
      otherCosts: json['other_costs'] as String?,
      receipts: (json['receipts'] as List<dynamic>?)
          ?.map((e) => Receipt.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MilestoneToJson(Milestone instance) => <String, dynamic>{
      'acct_id': instance.acctId,
      'sr_no': instance.srNo,
      'milestone_id': instance.milestoneId,
      'event_name': instance.eventName,
      'status': instance.status,
      'due_date': instance.dueDate,
      'amount': instance.amount,
      'receipt_ids': instance.receiptIds,
      'receipt_dt': instance.receiptDt,
      'recv_amt': instance.recvAmt,
      'outstanding_amt': instance.outstandingAmt,
      'intrest_recv_amount': instance.intrestRecvAmount,
      'receipts': instance.receipts,
      'apartment_cost': instance.apartmentCost,
      'taxes': instance.taxes,
      'other_costs': instance.otherCosts,
    };
