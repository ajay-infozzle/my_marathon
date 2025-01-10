import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:marathon/data/services/analytics_service.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data/server/api/api_const.dart';
import '../../../data/storage/app/app_holder.dart';
import '../../../data/tools/toast/custom_snackbar.dart';
import '../../../domain/entities/login/login_response.dart';
import '../../../domain/use_cases/auth/login_use_case.dart';
import '../../../view/main_page/main_page.dart';
import '../../base/base_controller.dart';

class PasswordVerificationController extends BaseController {
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  LoginUseCase loginUseCase;
  LoginResponse? loginResponse;

  PasswordVerificationController(this.loginUseCase);
  String? token;
  void login(bool isNumber, String mailOrNumber) async {
    if (passwordController.text.isEmpty) {
      customSnackBar("please enter Password");
      return;
    }
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      token = await messaging.getToken();
      log('FcmToken===>>> $token');
      Get.find<AppHolder>().fCMToken = token ?? "";
      log('Get.find<AppHolder>().fCMToken==========>>>>>${Get.find<AppHolder>().fCMToken}');
    } catch (e) {
      log('eeee>> $e');
    }
    log('fCMTokenLogin==========>>>>>${Get.find<AppHolder>().fCMToken}');
    log('token==========>>>>>$token');
    Map<String, dynamic> request = isNumber
        ? {
            "mobile": mailOrNumber,
            "password": passwordController.text,
            "fcm": token
          }
        : {
            "email": mailOrNumber,
            "password": passwordController.text,
            "fcm": token
          };
    Map<String, dynamic> params = {"apikey": Api.apiKey, "action": "login"};
    log('request====------>>>>>$request');
    log('params=====------>>>>>$params');
    loginUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.data?.custId != 0) {
          final userId = response?.data?.userId ?? 0;
          final custId = response?.data?.custId ?? 0;
          final email = response?.data?.email ?? '';
          final mobile = response?.data?.mobile ?? '';
          final name = response?.data?.name ?? '';

          AnalyticsService.instance.onLogin(
              loginType: isNumber ? 'mobile' : 'email', userId: custId);

          Get.find<AppHolder>().id = userId;
          Get.find<AppHolder>().custId = custId;
          Get.find<AppHolder>().email = email;
          Get.find<AppHolder>().number = mobile;
          Get.find<AppHolder>().name = name;

          Get.offAll(() => const MainPage(isSignIn: true));
        } else {
          customSnackBar(response?.message ?? "");
        }
      }, error: (error) {
        customSnackBar("Your account has been deleted , Please contact support to register again.");
      });
    })
      ..onDone(() async {
        isLoading = false;
        update();
      })
      ..addTo(subscribe);
  }

  void hidePassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  void hideConfirmPassword() {
    confirmPasswordVisible = !confirmPasswordVisible;
    update();
  }
}
