import 'package:marathon/domain/entities/my_account/my_account_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data/server/error_parser.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';

class MyAccountUseCase {
  final AppRepo _repo;

  MyAccountUseCase(
    this._repo,
  );

  Stream<Result<MyAccountResponse?>> invoke(
          Map<String, dynamic> request, Map<String, dynamic> params) =>
      _repo
          .myAccountData(request, params)
          .map((response) {
            if (response != null) {}
            return Result.content(response);
          })
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
