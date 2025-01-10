import 'package:marathon/domain/entities/refer/refer_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data/server/error_parser.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';

class ReferUseCase {
  final AppRepo _repo;

  ReferUseCase(
    this._repo,
  );

  Stream<Result<ReferResponse?>> invoke(Map<String, dynamic> request) => _repo
      .referData(request)
      .map((response) {
        if (response != null) {}
        return Result.content(response);
      })
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
