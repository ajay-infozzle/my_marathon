import 'dart:io';

import 'package:marathon/domain/entities/document_post/post_document_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/server/error_parser.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';

class PostDocumentsUseCase {
  final AppRepo _repo;

  PostDocumentsUseCase(
    this._repo,
  );

  Stream<Result<PostDocumentResponse?>> invoke(
          Map<String, dynamic> params,
          File documentFile,
          String? apartmentId,
          String? documentType,
          String? documentName,
          String? custId) =>
      _repo
          .documentPost(params, documentFile, apartmentId, documentType,
              documentName, custId) //   Stream<TokenResponse>
          .map((response) {
            if (response != null) {}
            return Result.content(response);
          })
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
