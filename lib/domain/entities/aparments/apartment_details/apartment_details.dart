import 'package:json_annotation/json_annotation.dart';

part 'apartment_details.g.dart';

@JsonSerializable()
class ApartmentDetails {
  @JsonKey(name: 'acct_id')
  String? acctId;
  @JsonKey(name: 'cust_id')
  String? custId;
  @JsonKey(name: 'cust_title')
  String? custTitle;
  @JsonKey(name: 'cust_first_name')
  String? custFirstName;
  @JsonKey(name: 'cust_last_name')
  String? custLastName;
  @JsonKey(name: 'flat_no')
  String? flatNo;
  @JsonKey(name: 'project_name')
  String? projectName;
  String? subprojid;
  @JsonKey(name: 'sub_projectname')
  String? subProjectname;
  @JsonKey(name: 'booking_date')
  String? bookingDate;
  @JsonKey(name: 'aggrement_date')
  String? aggrementDate;
  @JsonKey(name: 'carpet_area')
  String? carpetArea;
  @JsonKey(name: 'carpet_area_rera')
  String? carpetAreaRera;
  @JsonKey(name: 'ReraCarpet_EnclBal_OpenBal')
  String? reraCarpetEnclBalOpenBal;
  @JsonKey(name: 'floor_no')
  String? floorNo;
  @JsonKey(name: 'unit_type_name')
  String? unitTypeName;
  @JsonKey(name: 'certifying_company')
  String? certifyingCompany;
  @JsonKey(name: 'company_printname')
  String? companyPrintname;
  @JsonKey(name: 'company_code')
  String? companyCode;
  @JsonKey(name: 'company_cin')
  String? companyCin;
  @JsonKey(name: 'company_gstno')
  String? companyGstno;
  @JsonKey(name: 'comp_address')
  String? compAddress;
  @JsonKey(name: 'project_address')
  String? projectAddress;
  String? website;
  String? telno;
  @JsonKey(name: 'cc_email')
  String? ccEmail;
  @JsonKey(name: 'maintenance_account_no')
  dynamic maintenanceAccountNo;
  @JsonKey(name: 'agreement_value')
  String? agreementValue;
  @JsonKey(name: 'received_percent')
  int? receivedPercent;

  ApartmentDetails({
    this.acctId,
    this.custId,
    this.custTitle,
    this.custFirstName,
    this.custLastName,
    this.flatNo,
    this.projectName,
    this.subprojid,
    this.subProjectname,
    this.bookingDate,
    this.aggrementDate,
    this.carpetArea,
    this.carpetAreaRera,
    this.reraCarpetEnclBalOpenBal,
    this.floorNo,
    this.unitTypeName,
    this.certifyingCompany,
    this.companyPrintname,
    this.companyCode,
    this.companyCin,
    this.companyGstno,
    this.compAddress,
    this.projectAddress,
    this.website,
    this.telno,
    this.ccEmail,
    this.maintenanceAccountNo,
    this.agreementValue,
    this.receivedPercent,
  });

  Map<String, dynamic> toJson() => _$ApartmentDetailsToJson(this);

  factory ApartmentDetails.fromJson(Map<String, dynamic> json) =>
      _$ApartmentDetailsFromJson(json);

  @override
  String toString() => toJson().toString();
}
