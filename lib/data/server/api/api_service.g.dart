// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiService implements ApiService {
  _ApiService(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Stream<LoginResponse?> getInfo(
    Map<String, dynamic> params,
    Map<String, dynamic> request,
  ) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap(request);
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<LoginResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data == null ? null : LoginResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<ApartmentsList?> getApartments(
    Map<String, dynamic> params,
    Map<String, dynamic> request,
  ) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap(request);
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<ApartmentsList>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data == null ? null : ApartmentsList.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<ApartmentDetailsResponse?> getAparmentDetails(
    Map<String, dynamic> params,
    Map<String, dynamic> request,
  ) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap(request);
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<ApartmentDetailsResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data == null
        ? null
        : ApartmentDetailsResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<LedgerDetailsResponse?> getLedger(
    Map<String, dynamic> params,
    Map<String, dynamic> request,
  ) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap(request);
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<LedgerDetailsResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data == null
        ? null
        : LedgerDetailsResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<DocumentsResponse?> getDocuments(
    Map<String, dynamic> params,
    Map<String, dynamic> request,
  ) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap(request);
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<DocumentsResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data == null ? null : DocumentsResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<MessageData?> message(
    Map<String, dynamic> params,
    Map<String, dynamic> request,
  ) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap(request);
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<MessageData>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data == null ? null : MessageData.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<PostDocumentResponse?> documentPost(
    Map<String, dynamic> params, {
    File? documentFile,
    String? apartmentId,
    String? documentType,
    String? documentName,
    String? custId,
  }) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (documentFile != null) {
      _data.files.add(MapEntry(
        'document_file',
        MultipartFile.fromFileSync(
          documentFile.path,
          filename: documentFile.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    if (apartmentId != null) {
      _data.fields.add(MapEntry(
        'apartment_id',
        apartmentId,
      ));
    }
    if (documentType != null) {
      _data.fields.add(MapEntry(
        'document_type',
        documentType,
      ));
    }
    if (documentName != null) {
      _data.fields.add(MapEntry(
        'document_name',
        documentName,
      ));
    }
    if (custId != null) {
      _data.fields.add(MapEntry(
        'cust_id',
        custId,
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<PostDocumentResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data == null
        ? null
        : PostDocumentResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<MessageData?> sendMessage(
    Map<String, dynamic> params, {
    File? documentFile,
    String? subject,
    String? email,
    String? message,
  }) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (documentFile != null) {
      _data.files.add(MapEntry(
        'document_file',
        MultipartFile.fromFileSync(
          documentFile.path,
          filename: documentFile.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    if (subject != null) {
      _data.fields.add(MapEntry(
        'subject',
        subject,
      ));
    }
    if (email != null) {
      _data.fields.add(MapEntry(
        'email',
        email,
      ));
    }
    if (message != null) {
      _data.fields.add(MapEntry(
        'message',
        message,
      ));
    }
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<MessageData>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data == null ? null : MessageData.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<PaymentResponse?> paymentInfo(
    Map<String, dynamic> params,
    Map<String, dynamic> request,
  ) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap(request);
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<PaymentResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data == null ? null : PaymentResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<AllProjectResponse?> getAllProject() async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<AllProjectResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://marathon.in/wp-json/marathon-api/v1/all-projects',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data == null
        ? null
        : AllProjectResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<FaqDataResponse?> getFaqData(Map<String, dynamic> params) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<FaqDataResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data == null ? null : FaqDataResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<ReferResponse?> referData(Map<String, dynamic> request) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap(request);
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<ReferResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://hooks.zapier.com/hooks/catch/293636/2b2t5vf/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data == null ? null : ReferResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<MyAccountResponse?> myAccountData(
    Map<String, dynamic> request,
    Map<String, dynamic> params,
  ) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap(request);
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<MyAccountResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data == null ? null : MyAccountResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<ReferProjectResponse?> referProjectData(
      Map<String, dynamic> params) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<ReferProjectResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://crm.marathon.in/api/getinfoformobileapp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data == null
        ? null
        : ReferProjectResponse.fromJson(_result.data!);
    yield value;
  }

  @override
  Stream<TermsAndConditionResponse?> termsAndConditionData() async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<TermsAndConditionResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://marathon.in/wp-json/marathon-api/v1/terms-and-conditions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data == null
        ? null
        : TermsAndConditionResponse.fromJson(_result.data!);
    yield value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
