import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/auth/authController.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/auth_pages/register_page/register_page.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import '../../data/tools/decoration/dimens.dart';
import '../../data/tools/decoration/res_colors.dart';
import '../../data/tools/decoration/style_res.dart';
import '../widgets/sheet_back_button.dart';

class LoginScreen extends StatelessWidget {
  final bool isSignIn;

  const LoginScreen({
    super.key,
    this.isSignIn = true,
  });

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return GetBuilder<AuthController>(
        init: AuthController(Get.find()),
        builder: (controller) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const SheetBackButton(
                scrollable: true,
              ),
              Container(
                padding: EdgeInsets.all(Dimens.padding),
                height: Get.height * 0.9,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Dimens.sheetRadius)),
                ),
                child: Column(
                  children: [
                    10.ph,
                    Text(
                      isSignIn ? 'Sign in' : "Forgot Password?",
                      style: kRegularThemeTextStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    20.ph,
                    Container(
                      width: 260,
                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(Dimens.buttonRadius), color: ColorRes.greyColor),
                      child: Row(
                        children: [
                          CustomGeneralButton(
                            horizontalPadding: 25,
                            verticalPadding: 7,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            onTab: () {
                              controller.tapEmailButton(true);
                            },
                            title: "Mobile",
                            width: 130,
                            buttonColor: controller.isNumber
                                ? ColorRes.mainButtonColor
                                : ColorRes.greyColor,
                            titleColor: !controller.isNumber
                                ? ColorRes.mainTextColor
                                : ColorRes.white,
                          ),
                          CustomGeneralButton(
                            horizontalPadding: 25,
                            verticalPadding: 7,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            onTab: () {
                              controller.tapEmailButton(false);
                            },
                            title: "Email",
                            width: 130,
                            buttonColor: !controller.isNumber
                                ? ColorRes.mainButtonColor
                                : ColorRes.greyColor,
                            titleColor: controller.isNumber
                                ? ColorRes.mainTextColor
                                : ColorRes.white,
                          ),
                        ],
                      ),
                    ),
                    30.ph,
                    SizedBox(
                      width: Get.width,
                      child: Text(
                        isSignIn
                            ? (controller.isNumber ? "Mobile" : 'Email')
                            : (controller.isNumber
                                ? "Registered Mobile Number"
                                : 'Registered Email id'),
                        style: kRegularWhiteTextStyle.copyWith(
                            fontSize: 20, color: ColorRes.mainTextColor),
                      ),
                    ),
                    10.ph,
                    !controller.isNumber
                        ? Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: ColorRes.greyD3,
                                    spreadRadius: 1,
                                    blurRadius: 0,
                                    offset: Offset(
                                        0.5, 1.5), // changes position of shadow
                                  ),
                                ],
                                color: ColorRes.textFieldColor,
                                borderRadius:
                                    BorderRadius.circular(Dimens.buttonRadius)),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Dimens.buttonRadius),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  child: TextFormField(
                                    controller: controller.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                )),
                          )
                        : Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: ColorRes.greyD3,
                                    spreadRadius: 1,
                                    blurRadius: 0,
                                    offset: Offset(0.5, 1.5),
                                  ),
                                ],
                                color: ColorRes.textFieldColor,
                                borderRadius:
                                    BorderRadius.circular(Dimens.buttonRadius)),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Dimens.buttonRadius),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            child: FormField<String?>(
                                              initialValue: 'us',
                                              onSaved: (newValue) {},
                                              builder: (state) =>
                                                  CountryCodePicker(
                                                      showDropDownButton: true,
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium,
                                                      showFlag: false,
                                                      enabled: true,
                                                      initialSelection: 'in',
                                                      onChanged: (code) {
                                                        state.didChange(
                                                            code.code);
                                                        Get.log(code.code
                                                            .toString());
                                                        controller
                                                            .findCountryCode(
                                                                code.dialCode ??
                                                                    "1");
                                                      }),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: controller.countryCode
                                                            .length ==
                                                        1
                                                    ? 70
                                                    : controller.countryCode
                                                                .length ==
                                                            2
                                                        ? 80
                                                        : 90),
                                            width: (Get.width - 150),
                                            child: TextFormField(
                                              keyboardType: TextInputType.phone,
                                              controller:
                                                  controller.numberController,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    10)
                                              ],
                                              onChanged: (e) {
                                                if (e.length == 10) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                    30.ph,
                    GestureDetector(
                      onTap: () {
                        isSignIn
                            ? controller.continueLogin()
                            : controller.submitForgotNumber();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        //height: 40,
                        width: MediaQuery.of(context).size.width * 0.41,
                        decoration: BoxDecoration(
                            color: ColorRes.mainButtonColor,
                            borderRadius:
                                BorderRadius.circular(Dimens.buttonRadius)),
                        child: Center(
                          child: controller.isLoading
                              ? const CircularProgressIndicator(
                                  color: ColorRes.white,
                                )
                              : Text(
                                  isSignIn ? "Continue with OTP" : "Submit",
                                  style: kRegularWhiteTextStyle.copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.038,
                                      fontWeight: FontWeight.w600,
                                      color: ColorRes.white),
                                ),
                        ),
                      ),
                    ),
                    10.ph,
                    Visibility(
                      visible: isSignIn,
                      child: Text(
                        'OR',
                        style: kRegularTextStyle.copyWith(fontSize: 16),
                      ),
                    ),
                    10.ph,
                    Visibility(
                      visible: isSignIn,
                      child: CustomGeneralButton(
                        onTab: () {
                          controller.continueWithPassword();
                        },
                        title: "Sign In with Password",
                        // width: 195
                      ),
                    ),
                    15.ph,
                    Visibility(
                      visible: isSignIn,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account? ',
                            style: kRegularTextStyle.copyWith(fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.bottomSheet(
                                  barrierColor: Colors.transparent,
                                  isScrollControlled: true,
                                  const RegisterScreen());
                            },
                            child: Text(
                              'Register',
                              style: kRegularTextStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.ph,
                    // commonBetaVersionEmail(),
                    // 10.ph,
                  ],
                ),
              ),
            ],
          );
        });
  }
}
