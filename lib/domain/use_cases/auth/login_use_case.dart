import 'dart:developer';

import 'package:rxdart/rxdart.dart';

import '../../../data/server/error_parser.dart';
import '../../../data/storage/app/app_holder.dart';
import '../../entities/login/login_response.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';


class LoginUseCase {
  final AppRepo _repo;
  final AppHolder _appHolder;

  LoginUseCase(this._repo, this._appHolder);

  Stream<Result<LoginResponse?>> invoke(Map<String, dynamic> params,Map<String,dynamic>request) => _repo
      .getInfo(params,request) //   Stream<TokenResponse>
      .map((response) {
        if (response != null) {
         // _appHolder.token = response.!;
       //   _appHolder.id = response.user?.id ?? 0;
        }

        log("Token is empty ${_appHolder.token.isEmpty}");
        return Result.content(response);
      })
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
