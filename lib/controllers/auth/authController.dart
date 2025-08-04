import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/data/services/analytics_service.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/data/tools/toast/custom_snackbar.dart';
import 'package:marathon/domain/entities/login/login_response.dart';
import 'package:marathon/domain/use_cases/auth/login_use_case.dart';
import 'package:marathon/view/auth_pages/verification_page/verification_page.dart';
import 'package:marathon/view/welcome_page.dart';
import 'package:rxdart/rxdart.dart';
import '../../data/server/api/api_const.dart';
import '../../view/auth_pages/verification_page/password_verification_page.dart';
import '../../view/main_page/main_page.dart';

class AuthController extends BaseController {
  bool isNumber = true;
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool verificated = false;
  bool isLoading = false;
  String countryCode = '91';
  String otp = '';
  bool isRegister = false;
  LoginUseCase loginUseCase;
  LoginResponse? loginResponse;
  bool isCheck = false;

  void termsAndCondition() {
    isCheck = !isCheck;
    update();
  }

  AuthController(this.loginUseCase);

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void updateOtp(String value) {
    otp = value;
    update();
  }

  void findCountryCode(String value) {
    Get.log(value);
    countryCode = value;
    update();
  }

  void tapEmailButton(bool value) {
    isNumber = value;
    update();
  }

  void hidePassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  void hideConfirmPassword() {
    confirmPasswordVisible = !confirmPasswordVisible;
    update();
  }

  void whenWritePhone(String phone) {
    update();
  }

  void whenWriteEmail(String email) {
    update();
  }

  void submitForgotNumber() {
    forgotOtpGet();
  }

  void continueLogin() async {
    if (emailController.text.isEmpty && isNumber == false) {
      customSnackBar("please enter email");
      return;
    }
    if (numberController.text.isEmpty && isNumber == true) {
      customSnackBar("please enter number");
      return;
    }
    if (!emailController.text.contains("@") && !isNumber) {
      customSnackBar("please enter email correctly");
      return;
    }
    if (numberController.text.length < 7 && isNumber) {
      customSnackBar("please enter number");
      return;
    }
    otpGet();
  }

  void continueWithPassword() async {
    if (emailController.text.isEmpty && isNumber == false) {
      customSnackBar("please enter email");
      return;
    }
    if (numberController.text.isEmpty && isNumber == true) {
      customSnackBar("please enter number");
      return;
    }
    if (!emailController.text.contains("@") && !isNumber) {
      customSnackBar("please enter email correctly");
      return;
    }

    // if (passwordController.text.isEmpty && isNumber == false) {
    //   customSnackBar("please enter password");
    //   return;
    // }

    if (numberController.text.length < 7 && isNumber) {
      customSnackBar("please enter number");
      return;
    }

    Get.back();
    Get.bottomSheet(
        barrierColor: Colors.transparent,
        isScrollControlled: true,
        PasswordVerificationPage(
          isNumber: isNumber,
          mailOrNumber: isNumber
              ? countryCode.split("+").last + numberController.text
              : emailController.text,
        ));
    return;
  }

  void continueRegister() {
    if (emailController.text.isEmpty && !isNumber) {
      customSnackBar("please enter email");
      return;
    }
    if (numberController.text.isEmpty && isNumber) {
      customSnackBar("please enter number");
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
    if (isCheck == false) {
      customSnackBar("please accept terms and condition");
      return;
    }
    passwordVisible = false;
    confirmPasswordVisible = false;

    register();
  }

  checkForgotOtp(int trueOtp) {
    if (verificated == true) {
      createNewPassword(trueOtp.toString());
      return;
    }
    if (otp != trueOtp.toString()) {
      customSnackBar('Wrong otp');
      return;
    }

    verificated = true;
    update();
  }

  void checkPassword() {
    // if(passwordController.text.isNotEmpty){
    //   Get.offAll(()=> const MainPage());
    // }
  }

  void forgotOtpGet() {
    // String code = countryCode.split('+').last;
    Map<String, dynamic> request = isNumber
        ? {"mobile": countryCode + numberController.text}
        : {"email": emailController.text};
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "forgot_password_get_otp"
    };
    log('request ---------->>>>>>>> $request');
    loginUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.data?.custId == 0) {
          customSnackBar(response?.message ?? "email or number is wrong");
        } else {
          Get.back();
          Get.bottomSheet(
              barrierColor: Colors.transparent,
              isScrollControlled: true,
              VerificationPage(isForgot: true, otp: response?.data?.otp ?? 0));
        }
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

  void otpGet() {
    if (isRegister == true) {
      register();
      return;
    }

    Map<String, dynamic> request = isNumber
        ? {"mobile": countryCode + numberController.text}
        : {"email": emailController.text};
    Get.log(request.toString());
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "login_otp_get"
    };
    log('request==========>>>>>$request');
    log('params==========>>>>>$params');
    loginUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.data?.custId == 0) {
          customSnackBar(response?.message ?? "email or number is wrong");
        } else {
          Get.back();
          Get.bottomSheet(
              barrierColor: Colors.transparent,
              isScrollControlled: true,
              VerificationPage(
                isLogin: true,
                isForgot: false,
                otp: response?.data?.otp ?? 0,
              ));
        }
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

  void createNewPassword(String otp) {
    Get.log(passwordController.text + confirmPassword.text);
    if (passwordController.text.isEmpty) {
      customSnackBar('Please, enter the password');
      return;
    } else if (passwordController.text != confirmPassword.text) {
      customSnackBar('Please, check the confirm password');
      return;
    }
    // String code = countryCode.split('+').last;
    Map<String, dynamic> request = isNumber
        ? {
            "mobile": countryCode + numberController.text,
            "otp": otp,
            "new_password": passwordController.text
          }
        : {
            "email": emailController.text,
            "otp": otp,
            "new_password": passwordController.text
          };
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "forgot_password_change"
    };
    loginUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.status != "success") {
          customSnackBar(response?.message ?? "");
        } else {
          customSnackBar(response?.message ?? "");
          Get.offAll(() => const WelcomePage());
        }
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

  void login(String otp, int trueOtp) async{
    if (isRegister == true) {
      registerVerify();
      return;
    }
    if (otp != trueOtp.toString()) {
      customSnackBar('Wrong otp');
      return;
    }

    //~
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      token = await messaging.getToken();
      log('FcmToken===>>> $token');
      Get.find<AppHolder>().fCMToken = token ?? "";
      log('Get.find<AppHolder>().fCMToken==========>>>>>${Get.find<AppHolder>().fCMToken}');
    } catch (e) {
      log('eeee>> $e');
    }
    //~

    // String code = countryCode.split('+').last;
    Map<String, dynamic> request = isNumber
        ? {"mobile": countryCode + numberController.text, "otp": otp, "fcm": token,}
        : {"email": emailController.text, "otp": otp, "fcm": token,};
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "login_otp_post"
    };
    log('request==========>>>>>$request');
    log('params==========>>>>>$params');
    loginUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.status == 'error') {
          customSnackBar(response?.message ?? "");
        } else {
          final userId = response?.data?.userId ?? 0;
          final custId = response?.data?.custId ?? 0;
          final email = response?.data?.email ?? '';
          final mobile = response?.data?.mobile ?? '';
          final name = response?.data?.name ?? '';

          AnalyticsService.instance.onLogin(loginType: isNumber ? 'mobile' : 'email', userId: custId);

          Get.find<AppHolder>().id = userId;
          Get.find<AppHolder>().custId = custId;
          Get.find<AppHolder>().email = email;
          Get.find<AppHolder>().number = mobile;
          Get.find<AppHolder>().name = name;

          Get.offAll(() => const MainPage(isSignIn: true));
        }
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

  void changePassword() {
    isRegister = true;
    Map<String, dynamic> request = isNumber
        ? {
            "mobile": Get.find<AppHolder>().number,
            "current_password": numberController.text,
            "new_password": passwordController.text,
            "new_password_confirm": confirmPassword.text
          }
        : {
            "email": Get.find<AppHolder>().email,
            "current_password": numberController.text,
            "new_password": passwordController.text,
            "new_password_confirm": confirmPassword.text
          };
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "change_password"
    };
    Get.log(request.toString());
    loginUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.status != null && response?.status == 'success') {
          Get.back();
          customSnackBar(response?.message ?? "Password changed ");
        } else if (response?.data?.custId != 0) {
          customSnackBar(response?.message ?? "Invalid");
        }
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

  String? token;

  //~
  void register() async {
    isRegister = true;
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
            "mobile": countryCode + numberController.text,
            "password": passwordController.text,
            "password_confirm": confirmPassword.text,
            "fcm": token,
          }
        : {
            "email": emailController.text,
            "password": passwordController.text,
            "password_confirm": confirmPassword.text,
            "fcm": token,
          };
          //~
        // : {
        //     "email": countryCode + numberController.text,
        //     "password": passwordController.text,
        //     "password_confirm": confirmPassword.text,
        //     "fcm": token,
        //   };
    Map<String, dynamic> params = {"apikey": Api.apiKey, "action": "register"};
    log('params==========>>>>>$params');
    log('request==========>>>>>$request');
    Get.log(request.toString());

    loginUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.status != null && response?.status == 'success') {
          //~
          AnalyticsService.instance.onRegister(
            registerType: isNumber ? 'mobile' : 'email', registeredId: isNumber?(countryCode + numberController.text): emailController.text
          );
          //~

          confirmPassword.text = "";
          passwordController.text = "";
          Get.back();
          Get.bottomSheet(
              barrierColor: Colors.transparent,
              isScrollControlled: true,
              const VerificationPage(
                otp: 0,
              ));
        } else {
          customSnackBar("please check your email or phone number");
        }
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

  void registerVerify() {
    Map<String, dynamic> request = isNumber
        ? {"mobile": numberController.text, "otp": otp}
        : {"email": emailController.text, "otp": otp};
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "register_verify"
    };
    loginUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.status == "success") {
          Get.find<AppHolder>().custId = response?.data?.custId ?? 0;
          Get.find<AppHolder>().email = response?.data?.email ?? "";
          Get.find<AppHolder>().number = response?.data?.mobile ?? "";
          Get.find<AppHolder>().name = response?.data?.name ?? "";
          Get.offAll(() => const MainPage(
                isSignIn: true,
              ));
        } else {
          customSnackBar(response?.message ?? "");
        }
      }, error: (error) {
        //  (error ?? '').toast;
      });
    })
      ..onDone(() async {
        isLoading = false;
        update();
      })
      ..addTo(subscribe);
  }
}
