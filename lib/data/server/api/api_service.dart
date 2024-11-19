import 'dart:io';
import 'package:dio/dio.dart';
import 'package:marathon/domain/entities/all_project/all_project_response.dart';
import 'package:marathon/domain/entities/aparments/apartment_details/apartment_details_response.dart';
import 'package:marathon/domain/entities/aparments/apartments_list.dart';
import 'package:marathon/domain/entities/documents/documents_response.dart';
import 'package:marathon/domain/entities/ledge/ledger_details_response.dart';
import 'package:marathon/domain/entities/ledge/payment/payment_response.dart';
import 'package:marathon/domain/entities/login/login_response.dart';
import 'package:marathon/domain/entities/message/message.dart';
import 'package:marathon/domain/entities/my_account/my_account_response.dart';
import 'package:marathon/domain/entities/refer/refer_project_response.dart';
import 'package:marathon/domain/entities/terms_and_condition/terms_and_condition_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import '../../../domain/entities/document_post/post_document_response.dart';
import '../../../domain/entities/refer/refer_response.dart';
import '../../../domain/entities/support/faq_data_response.dart';
import '../interceptors/auth.dart';
import 'api_const.dart';
part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(AuthInterceptor authInterceptor) {
    var options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 60000),
      sendTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      baseUrl: '',
    );
    Dio dio = Dio(options);
    dio.interceptors
      ..add(authInterceptor)
      ..add(LogInterceptor(requestBody: true, responseBody: true));
    return _ApiService(dio);
  }

  ///auth ----------------------------------------------------------------------
  @POST('${Api.baseUrl}${Api.getInfo}')
  Stream<LoginResponse?> getInfo(@Queries() Map<String, dynamic> params,
      @Part() Map<String, dynamic> request);

  ///Home
  @POST('${Api.baseUrl}${Api.getInfo}')
  Stream<ApartmentsList?> getApartments(@Queries() Map<String, dynamic> params,
      @Part() Map<String, dynamic> request);

  @POST('${Api.baseUrl}${Api.getInfo}')
  Stream<ApartmentDetailsResponse?> getAparmentDetails(
      @Queries() Map<String, dynamic> params,
      @Part() Map<String, dynamic> request);

  @POST('${Api.baseUrl}${Api.getInfo}')
  Stream<LedgerDetailsResponse?> getLedger(
      @Queries() Map<String, dynamic> params,
      @Part() Map<String, dynamic> request);

  @POST('${Api.baseUrl}${Api.getInfo}')
  Stream<DocumentsResponse?> getDocuments(
      @Queries() Map<String, dynamic> params,
      @Part() Map<String, dynamic> request);

  @POST('${Api.baseUrl}${Api.getInfo}')
  Stream<MessageData?> message(@Queries() Map<String, dynamic> params,
      @Part() Map<String, dynamic> request);

  @POST('${Api.baseUrl}${Api.getInfo}')
  @MultiPart()
  Stream<PostDocumentResponse?> documentPost(
      @Queries() Map<String, dynamic> params,
      {@Part(name: 'document_file') File? documentFile,
      @Part(name: 'apartment_id') String? apartmentId,
      @Part(name: 'document_type') String? documentType,
      @Part(name: 'document_name') String? documentName,
      @Part(name: 'cust_id') String? custId});

  @POST('${Api.baseUrl}${Api.getInfo}')
  @MultiPart()
  Stream<MessageData?> sendMessage(
    @Queries() Map<String, dynamic> params, {
    // @Part(name: 'attachment_file') File? documentFile,
    @Part(name: 'document_file') File? documentFile,
    @Part(name: 'subject') String? subject,
    @Part(name: 'email') String? email,
    @Part(name: 'message') String? message,
  });

  @POST('${Api.baseUrl}${Api.getInfo}')
  @MultiPart()
  Stream<PaymentResponse?> paymentInfo(@Queries() Map<String, dynamic> params,
      @Part() Map<String, dynamic> request);

  @GET(Api.getAllProject)
  Stream<AllProjectResponse?> getAllProject();

  @POST('${Api.baseUrl}${Api.getInfo}')
  Stream<FaqDataResponse?> getFaqData(@Queries() Map<String, dynamic> params);

  @POST(Api.referApi)
  Stream<ReferResponse?> referData(@Part() Map<String, dynamic> request);

  @POST('${Api.baseUrl}${Api.getInfo}')
  Stream<MyAccountResponse?> myAccountData(@Part() Map<String, dynamic> request,@Queries() Map<String, dynamic> params);

  @GET('${Api.baseUrl}${Api.getInfo}')
  Stream<ReferProjectResponse?> referProjectData(@Queries() Map<String, dynamic> params);

  @GET(Api.getTermsAndCondition)
  Stream<TermsAndConditionResponse?> termsAndConditionData();

}
