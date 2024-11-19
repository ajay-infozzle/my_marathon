import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../tools/exceptions/custom_exception.dart';

class ErrorParser {
  static String parse(error) {
    Get.log("ERROR PARSER: $error");

    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.badResponse:
              var errorBody = error.response?.data['msg'];
              if (errorBody != null) {
                return errorBody;
              }
              return error.response?.data == null
                  ? ' status code ${error.response?.statusCode}'
                  : error.response!.data.toString();
            default: return 'Please! check your network connection';
          }
        }
        if (error is NotValidException) {
          return error.message;
        }
        return error.toString();
      } on FormatException catch (e) {
        log("Error parser $e");
        return 'error on format';
      } catch (e) {
        log("Error parser catch $e", error: SocketException(e.toString()));
        return 'error $e';
      }
    }
    return error.toString().contains("is not a subtype of")
        ? ' eroor this is $error'
        : 'error 1 $error';
  }
}
