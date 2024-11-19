import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/data/tools/toast/custom_snackbar.dart';

import '../../view/main_page/main_page.dart';

class ChangePasswordControllerr extends BaseController {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void continueRegister() {
    if (currentPasswordController.text.isEmpty) {
      customSnackBar("please enter current password");
      return;
    }
    if (passwordController.text.isEmpty) {
      customSnackBar("please enter password");
      return;
    }
    if (confirmPassword.text.isEmpty) {
      customSnackBar("please enter confirm password");
      return;
    }
    if (passwordController.text != confirmPassword.text) {
      customSnackBar("please check confirm password");
      return;
    }
    Get.back();
    Get.offAll(() => const MainPage());
  }
}
