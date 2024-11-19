import 'package:marathon/domain/entities/support/faq_data_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/server/error_parser.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';

class GetFaqDataUseCase {
  final AppRepo _repo;

  GetFaqDataUseCase(
    this._repo,
  );

  Stream<Result<FaqDataResponse?>> invoke(Map<String, dynamic> params) => _repo
      .getFaqData(params) //   Stream<TokenResponse>
      .map((response) {
        if (response != null) {}
        return Result.content(response);
      })
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
