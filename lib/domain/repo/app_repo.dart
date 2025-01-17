import 'dart:io';

import 'package:marathon/domain/entities/all_project/all_project_response.dart';
import 'package:marathon/domain/entities/aparments/apartment_details/apartment_details_response.dart';
import 'package:marathon/domain/entities/aparments/apartments_list.dart';
import 'package:marathon/domain/entities/ledge/ledger_details_response.dart';
import 'package:marathon/domain/entities/ledge/payment/payment_response.dart';
import 'package:marathon/domain/entities/message/message.dart';
import 'package:marathon/domain/entities/my_account/my_account_response.dart';

import '../entities/document_post/post_document_response.dart';
import '../entities/documents/documents_response.dart';
import '../entities/login/login_response.dart';
import '../entities/refer/refer_project_response.dart';
import '../entities/refer/refer_response.dart';
import '../entities/support/faq_data_response.dart';
import '../entities/terms_and_condition/terms_and_condition_response.dart';

abstract class AppRepo {
  ///auth ----------------------------------------------------------------------
  Stream<LoginResponse?> getInfo(
      Map<String, dynamic> params, Map<String, dynamic> request);

  Stream<ApartmentsList?> getApartments(
      Map<String, dynamic> params, Map<String, dynamic> request);

  Stream<ApartmentDetailsResponse?> getAparmentDetails(
      Map<String, dynamic> params, Map<String, dynamic> request);

  Stream<LedgerDetailsResponse?> getLedger(
      Map<String, dynamic> params, Map<String, dynamic> request);

  Stream<DocumentsResponse?> getDocuments(
      Map<String, dynamic> params, Map<String, dynamic> request);

  Stream<MessageData?> message(
      Map<String, dynamic> params, Map<String, dynamic> request);

  Stream<PostDocumentResponse?> documentPost(
    Map<String, dynamic> params,
    File documentFile,
    String? apartmentId,
    String? documentType,
    String? documentName,
    String? custId,
  );

  Stream<MessageData?> sendMessage(Map<String, dynamic> params,
      File? documentFile, String? email, String? message, String? subject);

  Stream<PaymentResponse?> paymentInfo(
      Map<String, dynamic> params, Map<String, dynamic> request);

  Stream<AllProjectResponse?> getAllProject();

  Stream<FaqDataResponse?> getFaqData(Map<String, dynamic> params);

  Stream<ReferResponse?> referData(Map<String, dynamic> request);

  Stream<MyAccountResponse?> myAccountData(Map<String, dynamic> params, Map<String, dynamic> request);

  Stream<ReferProjectResponse?> referProjectData(Map<String, dynamic> params);

  Stream<TermsAndConditionResponse?>  termsAndConditionData();
}
