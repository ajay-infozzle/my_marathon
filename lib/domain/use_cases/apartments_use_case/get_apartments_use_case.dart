import 'dart:developer';

import 'package:marathon/domain/entities/aparments/apartments_list.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/server/error_parser.dart';
import '../../../data/storage/app/app_holder.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';

class GetApartmentsUseCase {

  final AppRepo _repo;

  GetApartmentsUseCase(this._repo,);

  Stream<Result<ApartmentsList?>> invoke(
          Map<String, dynamic> params, Map<String, dynamic> request) =>
      _repo
          .getApartments(params, request) //   Stream<TokenResponse>
          .map((response) {
            if (response != null) {
              // _appHolder.token = response.!;
              //   _appHolder.id = response.user?.id ?? 0;
            }
            return Result.content(response);
          })
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
