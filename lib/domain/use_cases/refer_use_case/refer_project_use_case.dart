import 'package:marathon/domain/entities/refer/refer_project_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/server/error_parser.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';

class ReferProjectUseCase{
  final AppRepo _repo;

  ReferProjectUseCase(
      this._repo,
      );

  Stream<Result<ReferProjectResponse?>> invoke(Map<String, dynamic> params) => _repo
      .referProjectData(params) //   Stream<TokenResponse>
      .map((response) {
    if (response != null) {}
    return Result.content(response);
  })
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
