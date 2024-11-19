import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:marathon/domain/entities/my_account/my_account_response.dart';
import 'package:marathon/domain/use_cases/my_account_use_case/my_account_use_case.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/server/api/api_const.dart';
import '../../data/storage/app/app_holder.dart';
import '../../data/tools/toast/custom_snackbar.dart';
import '../../view/splash/splash_page.dart';
import '../base/base_controller.dart';
import '../mainController/main_controller.dart';

class MyAccountController extends BaseController {
  MainController mainController = MainController();

  MyAccountUseCase myAccountUseCase;
  MyAccountResponse? myAccountResponse;
  bool isLoading = false;

  MyAccountController(this.myAccountUseCase);

  void myAccountDelete() {
    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
    };
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "delete_account",
    };
    Get.log(request.toString());
    myAccountUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        myAccountResponse = response;
        log('response==========>>>>>$response');
        customSnackBar("Account Successfully Deleted ");
        Get.find<AppHolder>().clearAuth();
        Get.offAll(() => const SplashPage());
        update();
      }, error: (error) {
        customSnackBar(error.toString());
      });
    })
      ..onDone(() async {
        isLoading = false;
        update();
      })
      ..addTo(subscribe);
  }
}
