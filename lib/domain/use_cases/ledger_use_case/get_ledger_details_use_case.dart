import 'package:marathon/domain/entities/ledge/ledger_details_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/server/error_parser.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';

class GetLedgerDetailsUseCase {
  final AppRepo _repo;

  GetLedgerDetailsUseCase(
    this._repo,
  );

  Stream<Result<LedgerDetailsResponse?>> invoke(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      _repo
          .getLedger(params, request) //   Stream<TokenResponse>
          .map((response) {
            if (response != null) {}
            return Result.content(response);
          })
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
