import 'package:marathon/domain/entities/documents/documents_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/server/error_parser.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';

class GetDocumentsUseCase {
  final AppRepo _repo;

  GetDocumentsUseCase(
    this._repo,
  );

  Stream<Result<DocumentsResponse?>> invoke(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      _repo
          .getDocuments(params, request) //   Stream<TokenResponse>
          .map((response) {
            if (response != null) {}
            return Result.content(response);
          })
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
