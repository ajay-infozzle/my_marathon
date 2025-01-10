import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/auth/authController.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/auth_pages/verification_page/password_verification_page.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import 'package:marathon/view/widgets/sheet_back_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../data/tools/decoration/dimens.dart';
import '../../../data/tools/decoration/res_colors.dart';
import '../../../data/tools/decoration/style_res.dart';
import '../../widgets/custom_textfield.dart';

class VerificationPage extends StatelessWidget {
  final bool isForgot;
  final bool isLogin;
  final int otp;
  const VerificationPage({
    super.key,
    this.isForgot = false,
    this.isLogin = false,
    required this.otp,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(Get.find()),
        builder: (controller) {
          return ListView(
            children: [
              const SheetBackButton(
                scrollable: true,
              ),
              Container(
                padding: EdgeInsets.all(Dimens.padding),
                height: Get.height * 0.75,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Dimens.sheetRadius)),
                ),
                child: Column(
                  children:[
                    10.ph,
                    Text(
                      isForgot ? "Change Password" : 'Welcome Back',
                      style: kRegularThemeTextStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    10.ph,
                    SizedBox(
                      width: Get.width / 2,
                      child: Text(
                        textAlign: TextAlign.center,
                        ' Please enter the OTP sent on +91********** and ma******@gmail.com',
                        style: kRegularThemeTextStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    20.ph,
                    Text(
                      textAlign: TextAlign.center,
                      'Input Code from Email id',
                      style: kRegularThemeTextStyle.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    Visibility(
                      visible: !controller.verificated,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 40),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: const TextStyle(
                              color: ColorRes.white,
                            ),
                            length: 4,
                            obscureText: false,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                                activeColor: ColorRes.greyD9,
                                disabledColor: Colors.black,
                                selectedColor: Colors.black,
                                shape: PinCodeFieldShape.box,
                                borderWidth: 0.1,
                                selectedFillColor: ColorRes.white,
                                disabledBorderWidth: 0.1,
                                errorBorderColor: ColorRes.black,
                                borderRadius: BorderRadius.circular(10.12),
                                fieldHeight: 66,
                                fieldWidth: 66,
                                activeFillColor: ColorRes.white,
                                inactiveColor: ColorRes.greyD9,
                                inactiveFillColor: ColorRes.white),
                            cursorColor: ColorRes.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(3, 3),
                                color: Colors.black12,
                                blurRadius: 1,
                              )
                            ],
                            onCompleted: (v) {
                              if (isForgot == false) controller.login(v, otp);
                            },
                            onChanged: (value) {
                              controller.updateOtp(value);
                            },
                            beforeTextPaste: (text) {
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                    ),
                    Visibility(
                        visible: controller.verificated,
                        child: Column(
                          children: [
                            30.ph,
                            SizedBox(
                              width: Get.width,
                              child: Text(
                                'Input New Password',
                                style: kRegularWhiteTextStyle.copyWith(
                                    fontSize: 20,
                                    color: ColorRes.mainTextColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            CustomTextField(
                                textEditingController:controller.passwordController,
                                onChanged: (v) {},
                                visible: controller.passwordVisible,
                                tapToHide: () {
                                  controller.hidePassword();
                                }),
                            30.ph,
                            SizedBox(
                              width: Get.width,
                              child: Text(
                                'Confirm New Password',
                                style: kRegularWhiteTextStyle.copyWith(
                                    fontSize: 20,
                                    color: ColorRes.mainTextColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            CustomTextField(
                              textEditingController: controller.confirmPassword,
                              onChanged: (v) {},
                              visible: controller.confirmPasswordVisible,
                              tapToHide: () {
                                controller.hideConfirmPassword();
                              },
                            ),
                            20.ph,
                          ],
                        )),
                    Visibility(
                      visible: !isLogin,
                      child: CustomGeneralButton(
                        onTab: () {
                          if (isLogin == true) {
                            Get.back();
                            Get.bottomSheet(
                                barrierColor: Colors.transparent,
                                isScrollControlled: true,
                                PasswordVerificationPage(
                                  isNumber: controller.isNumber,
                                  mailOrNumber: controller.isNumber
                                      ? controller.countryCode.split("+").last +
                                          controller.numberController.text
                                      : controller.emailController.text,
                                ));
                            return;
                          }
                          controller.verificated || isForgot
                              ? controller.checkForgotOtp(otp)
                              : controller.login(controller.otp, otp);
                        },
                        title: isLogin
                            ? 'Sign in with Password'
                            : (controller.verificated || isForgot
                                ? "Submit"
                                : "Verify"),
                        //   width: 195
                      ),
                    ),
                    20.ph,
                    Visibility(
                      visible: !controller.verificated && !isForgot,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text('Did not receive OTP?',style: kRegularTextStyle.copyWith(fontSize: 14)),
                          controller.isLoading
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    controller.otpGet();
                                  },
                                  child: Text(
                                    'Re-send code',
                                    style: kRegularTextStyle.copyWith(
                                        decoration: TextDecoration.underline,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    20.ph,
                   // commonBetaVersionEmail(),
                    //20.ph,
                  ],
                ),
              ),
            ],
          );
        });
  }
}
