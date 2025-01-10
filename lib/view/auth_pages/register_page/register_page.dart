import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/auth/authController.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/auth_pages/terms_and_condition/terms_and_condition_page.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import 'package:marathon/view/widgets/sheet_back_button.dart';
import '../../../data/tools/decoration/dimens.dart';
import '../../../data/tools/decoration/res_colors.dart';
import '../../../data/tools/decoration/style_res.dart';
import '../../widgets/custom_textfield.dart';
import '../login_page.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
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
                height: Get.height * 0.95,
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
                      'Register',
                      style: kRegularThemeTextStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    20.ph,
                    Container(
                      width: 260,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimens.buttonRadius),
                          color: ColorRes.greyColor),
                      child: Row(
                        children: [
                          CustomGeneralButton(
                            horizontalPadding: 25,
                            verticalPadding: 7,
                            onTab: () {
                              controller.tapEmailButton(true);
                            },
                            title: "Mobile",
                            width: 130,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
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
                            onTab: () {
                              controller.tapEmailButton(false);
                            },
                            title: "Email",
                            width: 130,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
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
                        controller.isNumber ? "Mobile" : 'Email',
                        style: kRegularWhiteTextStyle.copyWith(
                            fontSize: 20, color: ColorRes.mainTextColor),
                      ),
                    ),
                    10.ph,
                    !controller.isNumber
                        ? CustomTextField(
                            textEditingController: controller.emailController,
                            onChanged: (v) {},
                            tapToHide: () {},
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
                                              initialValue: 'in',
                                              onSaved: (newValue) {},
                                              builder: (state) =>
                                                  CountryCodePicker(
                                                showDropDownButton: true,
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                showFlag: false,
                                                enabled: true,
                                                initialSelection: 'in',
                                                onChanged: (code) =>
                                                    state.didChange(code.code),
                                              ),
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
                                              onChanged: (e) {},
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
                    25.ph,
                    SizedBox(
                      width: Get.width,
                      child: Text(
                        'Password',
                        style: kRegularWhiteTextStyle.copyWith(
                            fontSize: 20,
                            color: ColorRes.mainTextColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    CustomTextField(
                        textEditingController: controller.passwordController,
                        onChanged: (v) {},
                        visible: controller.passwordVisible,
                        needHide: true,
                        tapToHide: () {
                          controller.hidePassword();
                        }),
                    25.ph,
                    SizedBox(
                      width: Get.width,
                      child: Text(
                        'Re-enter Password',
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
                      needHide: true,
                      tapToHide: () {
                        controller.hideConfirmPassword();
                      },
                    ),
                    20.ph,
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: controller.isCheck,
                      onChanged: (value) {
                        controller.termsAndCondition();
                      },
                      side: const BorderSide(color: ColorRes.mainButtonColor),
                      activeColor: ColorRes.white,
                      checkColor: ColorRes.white,
                      fillColor: WidgetStatePropertyAll(
                          controller.isCheck == true
                              ? ColorRes.mainButtonColor
                              : ColorRes.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      title: Text.rich(
                        textAlign: TextAlign.start,
                        TextSpan(children: [
                          TextSpan(
                            text: 'By registering I agree to the',
                            style: kRegularTextStyle.copyWith(fontSize: 14),
                          ),
                          TextSpan(
                            text: ' terms and conditions',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                // final link = 'https://marathon.in/terms-and-conditions/';
                                // if (await canLaunch(link)) {
                                //   await launch(link);
                                // } else {
                                //   print('Could not open link$link');
                                // }
                                // controller.controller = WebViewController()
                                //   ..loadRequest(
                                //     Uri.parse(
                                //         'https://marathon.in/terms-and-conditions/'),
                                //   );
                                // WebViewWidget(
                                //   controller: controller.controller,
                                // );
                                Get.to(const TermsAndConditionPage());
                              },
                            style: kRegularTextStyle.copyWith(
                              fontSize: 14,
                              color: ColorRes.mainButtonColor,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorRes.mainButtonColor,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    15.ph,
                    CustomGeneralButton(
                      onTab: () {
                        controller.continueRegister();
                      },
                      title: "Register",
                    ),
                    15.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: kRegularTextStyle.copyWith(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.bottomSheet(
                                barrierColor: Colors.transparent,
                                isScrollControlled: true,
                                const LoginScreen());
                          },
                          child: Text(
                            'Sign In',
                            style: kRegularTextStyle.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    10.ph
                  ],
                ),
              ),
            ],
          );
        });
  }
}
