import 'dart:io';
import 'package:marathon/domain/entities/all_project/all_project_response.dart';
import 'package:marathon/domain/entities/aparments/apartment_details/apartment_details_response.dart';
import 'package:marathon/domain/entities/ledge/payment/payment_response.dart';
import 'package:marathon/domain/entities/my_account/my_account_response.dart';
import 'package:marathon/domain/entities/refer/refer_project_response.dart';
import 'package:marathon/domain/entities/refer/refer_response.dart';
import 'package:marathon/domain/entities/terms_and_condition/terms_and_condition_response.dart';
import '../../data/server/api/api_service.dart';
import '../entities/aparments/apartments_list.dart';
import '../entities/document_post/post_document_response.dart';
import '../entities/documents/documents_response.dart';
import '../entities/ledge/ledger_details_response.dart';
import '../entities/login/login_response.dart';
import '../entities/message/message.dart';
import '../entities/support/faq_data_response.dart';
import 'app_repo.dart';

class AppRepoImpl extends AppRepo {
  final ApiService api;

  AppRepoImpl(this.api);

// ///auth ----------------------------------------------------------------------
  @override
  Stream<LoginResponse?> getInfo(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      api.getInfo(params, request);

  /// home
  @override
  Stream<ApartmentsList?> getApartments(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      api.getApartments(params, request);

  @override
  Stream<ApartmentDetailsResponse?> getAparmentDetails(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      api.getAparmentDetails(params, request);

  @override
  Stream<LedgerDetailsResponse?> getLedger(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      api.getLedger(params, request);

  @override
  Stream<DocumentsResponse?> getDocuments(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      api.getDocuments(params, request);

  @override
  Stream<MessageData?> message(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      api.message(params, request);

  @override
  Stream<PostDocumentResponse?> documentPost(
          Map<String, dynamic> params,
          File documentFile,
          String? apartmentId,
          String? documentType,
          String? documentName,
          String? custId) =>
      api.documentPost(params,
          documentFile: documentFile,
          apartmentId: apartmentId,
          documentName: documentName,
          custId: custId,
          documentType: documentType);

  @override
  Stream<MessageData?> sendMessage(Map<String, dynamic> params,
          File documentFile, String? email, String? message, String? subject) =>
      api.sendMessage(params,
          documentFile: documentFile,
          message: message,
          subject: subject,
          email: email);

  @override
  Stream<PaymentResponse?> paymentInfo(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      api.paymentInfo(params, request);

  @override
  Stream<AllProjectResponse?> getAllProject() => api.getAllProject();

  @override
  Stream<FaqDataResponse?> getFaqData(Map<String, dynamic> params) =>
      api.getFaqData(params);

  @override
  Stream<ReferResponse?> referData(Map<String, dynamic> request) =>
      api.referData(request);

  @override
  Stream<MyAccountResponse?> myAccountData(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      api.myAccountData(request, params);

  @override
  Stream<ReferProjectResponse?> referProjectData(Map<String, dynamic> params) =>
      api.referProjectData(params);

  @override
  Stream<TermsAndConditionResponse?> termsAndConditionData() =>
      api.termsAndConditionData();
}
