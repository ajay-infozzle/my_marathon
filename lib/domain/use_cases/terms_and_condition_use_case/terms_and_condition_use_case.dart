import 'package:marathon/domain/entities/all_project/all_project_response.dart';
import 'package:marathon/domain/entities/result_common/result.dart';
import 'package:marathon/domain/entities/terms_and_condition/terms_and_condition_response.dart';
import 'package:marathon/domain/repo/app_repo.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../data/server/error_parser.dart';

class TermsAndConditionUseCase {
  final AppRepo _repo;

  TermsAndConditionUseCase(
    this._repo,
  );

  Stream<Result<TermsAndConditionResponse?>> invoke() => _repo
      .termsAndConditionData() //   Stream<TokenResponse>
      .map((response) {
        if (response != null) {}
        return Result.content(response);
      })
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
