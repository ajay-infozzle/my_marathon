import 'package:marathon/domain/entities/all_project/all_project_response.dart';
import 'package:marathon/domain/entities/result_common/result.dart';
import 'package:marathon/domain/repo/app_repo.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../data/server/error_parser.dart';

class AllProjectUseCase {
  final AppRepo _repo;

  AllProjectUseCase(
    this._repo,
  );

  Stream<Result<AllProjectResponse?>> invoke() => _repo
      .getAllProject() //   Stream<TokenResponse>
      .map((response) {
        if (response != null) {}
        return Result.content(response);
      })
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
