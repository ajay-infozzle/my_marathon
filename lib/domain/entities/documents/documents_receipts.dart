import 'package:json_annotation/json_annotation.dart';

part 'documents_receipts.g.dart';

@JsonSerializable()
class DocumentsReceipts {

  @JsonKey(name: 'download_link')
  String? downloadLink;
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
  @JsonKey(name: 'recv_amt')
  String? recvAmt;
  @JsonKey(name: 'outstanding_amt')
  String? outstandingAmt;
  @JsonKey(name: 'intrest_recv_amount')
  String? intrestRecvAmount;
  @JsonKey(name: 'cust_id')
  String? custId;
  @JsonKey(name: 'receipt_id')
  String? receiptId;
  @JsonKey(name: 'receipt_no')
  String? receiptNo;
  @JsonKey(name: 'project_name')
  String? projectName;
  @JsonKey(name: 'project_address')
  String? projectAddress;
  @JsonKey(name: 'flor_no')
  String? florNo;
  @JsonKey(name: 'cust_address')
  String? custAddress;
  @JsonKey(name: 'cust_phone')
  String? custPhone;
  @JsonKey(name: 'sub_project')
  String? subProject;
  @JsonKey(name: 'flat_no')
  String? flatNo;
  @JsonKey(name: 'cust_name')
  String? custName;
  @JsonKey(name: 'receipt_dt')
  String? receiptDt;
  @JsonKey(name: 'receipt_amount')
  String? receiptAmount;
  @JsonKey(name: 'cheque_no')
  String? chequeNo;
  @JsonKey(name: 'cheque_dt')
  String? chequeDt;
  @JsonKey(name: 'bank_name')
  String? bankName;
  @JsonKey(name: 'company_name')
  String? companyName;
  @JsonKey(name: 'company_print_name')
  String? companyPrintName;
  @JsonKey(name: 'company_gstno')
  String? companyGstno;
  @JsonKey(name: 'company_cin')
  String? companyCin;
  @JsonKey(name: 'company_address')
  String? companyAddress;


  DocumentsReceipts({
      this.downloadLink,
      this.acctId,
      this.srNo,
      this.milestoneId,
      this.eventName,
      this.status,
      this.dueDate,
      this.amount,
      this.recvAmt,
      this.outstandingAmt,
      this.intrestRecvAmount,
      this.custId,
      this.receiptId,
      this.receiptNo,
      this.projectName,
      this.projectAddress,
      this.florNo,
      this.custAddress,
      this.custPhone,
      this.subProject,
      this.flatNo,
      this.custName,
      this.receiptDt,
      this.receiptAmount,
      this.chequeNo,
      this.chequeDt,
      this.bankName,
      this.companyName,
      this.companyPrintName,
      this.companyGstno,
      this.companyCin,
      this.companyAddress});

  Map<String, dynamic> toJson() => _$DocumentsReceiptsToJson(this);

  factory DocumentsReceipts.fromJson(Map<String, dynamic> json) =>
      _$DocumentsReceiptsFromJson(json);

  @override
  String toString() => toJson().toString();
}
