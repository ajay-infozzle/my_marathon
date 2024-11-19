// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_receipts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsReceipts _$DocumentsReceiptsFromJson(Map<String, dynamic> json) =>
    DocumentsReceipts(
      downloadLink: json['download_link'] as String?,
      acctId: json['acct_id'] as String?,
      srNo: json['sr_no'] as String?,
      milestoneId: json['milestone_id'] as String?,
      eventName: json['event_name'] as String?,
      status: json['status'] as String?,
      dueDate: json['due_date'] as String?,
      amount: json['amount'] as String?,
      recvAmt: json['recv_amt'] as String?,
      outstandingAmt: json['outstanding_amt'] as String?,
      intrestRecvAmount: json['intrest_recv_amount'] as String?,
      custId: json['cust_id'] as String?,
      receiptId: json['receipt_id'] as String?,
      receiptNo: json['receipt_no'] as String?,
      projectName: json['project_name'] as String?,
      projectAddress: json['project_address'] as String?,
      florNo: json['flor_no'] as String?,
      custAddress: json['cust_address'] as String?,
      custPhone: json['cust_phone'] as String?,
      subProject: json['sub_project'] as String?,
      flatNo: json['flat_no'] as String?,
      custName: json['cust_name'] as String?,
      receiptDt: json['receipt_dt'] as String?,
      receiptAmount: json['receipt_amount'] as String?,
      chequeNo: json['cheque_no'] as String?,
      chequeDt: json['cheque_dt'] as String?,
      bankName: json['bank_name'] as String?,
      companyName: json['company_name'] as String?,
      companyPrintName: json['company_print_name'] as String?,
      companyGstno: json['company_gstno'] as String?,
      companyCin: json['company_cin'] as String?,
      companyAddress: json['company_address'] as String?,
    );

Map<String, dynamic> _$DocumentsReceiptsToJson(DocumentsReceipts instance) =>
    <String, dynamic>{
      'download_link': instance.downloadLink,
      'acct_id': instance.acctId,
      'sr_no': instance.srNo,
      'milestone_id': instance.milestoneId,
      'event_name': instance.eventName,
      'status': instance.status,
      'due_date': instance.dueDate,
      'amount': instance.amount,
      'recv_amt': instance.recvAmt,
      'outstanding_amt': instance.outstandingAmt,
      'intrest_recv_amount': instance.intrestRecvAmount,
      'cust_id': instance.custId,
      'receipt_id': instance.receiptId,
      'receipt_no': instance.receiptNo,
      'project_name': instance.projectName,
      'project_address': instance.projectAddress,
      'flor_no': instance.florNo,
      'cust_address': instance.custAddress,
      'cust_phone': instance.custPhone,
      'sub_project': instance.subProject,
      'flat_no': instance.flatNo,
      'cust_name': instance.custName,
      'receipt_dt': instance.receiptDt,
      'receipt_amount': instance.receiptAmount,
      'cheque_no': instance.chequeNo,
      'cheque_dt': instance.chequeDt,
      'bank_name': instance.bankName,
      'company_name': instance.companyName,
      'company_print_name': instance.companyPrintName,
      'company_gstno': instance.companyGstno,
      'company_cin': instance.companyCin,
      'company_address': instance.companyAddress,
    };
