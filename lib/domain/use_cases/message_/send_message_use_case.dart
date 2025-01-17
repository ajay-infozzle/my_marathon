import 'dart:io';

import 'package:marathon/domain/entities/message/message.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/server/error_parser.dart';
import '../../entities/result_common/result.dart';
import '../../repo/app_repo.dart';

class SendMessageUseCase {
  final AppRepo _repo;

  SendMessageUseCase(
    this._repo,
  );

  Stream<Result<MessageData?>> invoke(
          Map<String, dynamic> params,
          File? documentFile,
          String? documentType,
          String? message,
          String? subject) =>
      _repo
          .sendMessage(params, documentFile, documentType, message,
              subject) //   Stream<TokenResponse>
          .map((response) {
            if (response != null) {}
            return Result.content(response);
          })
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
