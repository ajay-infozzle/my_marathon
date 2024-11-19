// import 'dart:developer';
//
// import 'package:rxdart/rxdart.dart';
//
// import '../../entities/result_common/result.dart';
//
//
// class GetMeUseCase {
//   final AppRepo _repo;
//   final AppHolder _appHolder;
//
//   GetMeUseCase(this._repo, this._appHolder);
//
//   Stream<Result<UserResponse?>> invoke() => _repo
//       .getMe()
//       .map((response) {
//         if (response != null) {
//           _appHolder.name = response.user?.name ?? "";
//           _appHolder.id = response.user?.id ?? 0;
//         }
//         log("Token is empty ${_appHolder.token.isEmpty}");
//         return Result.content(response);
//       })
//       .onErrorReturnWith(
//           (error, stackTrace) => Result.error(ErrorParser.parse(error)))
//       .startWith(const Result.loading());
// }
