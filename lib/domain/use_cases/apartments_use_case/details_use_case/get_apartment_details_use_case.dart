import 'package:marathon/domain/entities/aparments/apartment_details/apartment_details_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../data/server/error_parser.dart';
import '../../../entities/result_common/result.dart';
import '../../../repo/app_repo.dart';

class GetApartmentDetailsUseCase {
  final AppRepo _repo;

  GetApartmentDetailsUseCase(
    this._repo,
  );

  Stream<Result<ApartmentDetailsResponse?>> invoke(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      _repo
          .getAparmentDetails(params, request) //   Stream<TokenResponse>
          .map((response) {
            if (response != null) {}
            return Result.content(response);
          })
          .onErrorReturnWith((error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
