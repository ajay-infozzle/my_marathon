// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApartmentDetails _$ApartmentDetailsFromJson(Map<String, dynamic> json) =>
    ApartmentDetails(
      acctId: json['acct_id'] as String?,
      custId: json['cust_id'] as String?,
      custTitle: json['cust_title'] as String?,
      custFirstName: json['cust_first_name'] as String?,
      custLastName: json['cust_last_name'] as String?,
      flatNo: json['flat_no'] as String?,
      projectName: json['project_name'] as String?,
      subprojid: json['subprojid'] as String?,
      subProjectname: json['sub_projectname'] as String?,
      bookingDate: json['booking_date'] as String?,
      aggrementDate: json['aggrement_date'] as String?,
      carpetArea: json['carpet_area'] as String?,
      carpetAreaRera: json['carpet_area_rera'] as String?,
      reraCarpetEnclBalOpenBal: json['ReraCarpet_EnclBal_OpenBal'] as String?,
      floorNo: json['floor_no'] as String?,
      unitTypeName: json['unit_type_name'] as String?,
      certifyingCompany: json['certifying_company'] as String?,
      companyPrintname: json['company_printname'] as String?,
      companyCode: json['company_code'] as String?,
      companyCin: json['company_cin'] as String?,
      companyGstno: json['company_gstno'] as String?,
      compAddress: json['comp_address'] as String?,
      projectAddress: json['project_address'] as String?,
      website: json['website'] as String?,
      telno: json['telno'] as String?,
      ccEmail: json['cc_email'] as String?,
      maintenanceAccountNo: json['maintenance_account_no'],
      agreementValue: json['agreement_value'] as String?,
      receivedPercent: json['received_percent'] as int?,
    );

Map<String, dynamic> _$ApartmentDetailsToJson(ApartmentDetails instance) =>
    <String, dynamic>{
      'acct_id': instance.acctId,
      'cust_id': instance.custId,
      'cust_title': instance.custTitle,
      'cust_first_name': instance.custFirstName,
      'cust_last_name': instance.custLastName,
      'flat_no': instance.flatNo,
      'project_name': instance.projectName,
      'subprojid': instance.subprojid,
      'sub_projectname': instance.subProjectname,
      'booking_date': instance.bookingDate,
      'aggrement_date': instance.aggrementDate,
      'carpet_area': instance.carpetArea,
      'carpet_area_rera': instance.carpetAreaRera,
      'ReraCarpet_EnclBal_OpenBal': instance.reraCarpetEnclBalOpenBal,
      'floor_no': instance.floorNo,
      'unit_type_name': instance.unitTypeName,
      'certifying_company': instance.certifyingCompany,
      'company_printname': instance.companyPrintname,
      'company_code': instance.companyCode,
      'company_cin': instance.companyCin,
      'company_gstno': instance.companyGstno,
      'comp_address': instance.compAddress,
      'project_address': instance.projectAddress,
      'website': instance.website,
      'telno': instance.telno,
      'cc_email': instance.ccEmail,
      'maintenance_account_no': instance.maintenanceAccountNo,
      'agreement_value': instance.agreementValue,
      'received_percent': instance.receivedPercent,
    };
