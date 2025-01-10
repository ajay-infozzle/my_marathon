import 'package:marathon/domain/entities/message/message.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/server/error_parser.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';

class MessageUseCase {
  final AppRepo _repo;

  MessageUseCase(
      this._repo,
      );

  Stream<Result<MessageData?>> invoke(
      Map<String, dynamic> params, Map<String, dynamic> request) =>
      _repo
          .message(params, request) //   Stream<TokenResponse>
          .map((response) {
        if (response != null) {}
        return Result.content(response);
      })
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
