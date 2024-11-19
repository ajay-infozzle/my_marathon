import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/auth/authController.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import 'package:marathon/view/widgets/sheet_back_button.dart';
import '../../../controllers/auth/password_verification_controller/password_verification_controller.dart';
import '../../../data/tools/decoration/dimens.dart';
import '../../../data/tools/decoration/res_colors.dart';
import '../../../data/tools/decoration/style_res.dart';
import '../../widgets/common_beta_version_email.dart';
import '../../widgets/custom_textfield.dart';
import '../login_page.dart';

class PasswordVerificationPage extends StatelessWidget {
  final bool isNumber;
  final String mailOrNumber;
  const PasswordVerificationPage({
    super.key,
    required this.isNumber,
    required this.mailOrNumber,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<PasswordVerificationController>(
        init: PasswordVerificationController(Get.find()),
        builder: (controller) {
          return ListView(
            children: [
              const SheetBackButton(
                scrollable: true,
              ),
              Container(
                padding: EdgeInsets.all(Dimens.padding),
                height: Get.height * 0.8,
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
                      'Welcome Back',
                      style: kRegularThemeTextStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    20.ph,
                    Visibility(
                        child: Column(
                        children: [
                        30.ph,
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
                            visible: controller.passwordVisible,
                            needHide: true,
                            textEditingController:
                                controller.passwordController,
                            onChanged: (v) {},
                            tapToHide: () {
                              controller.hidePassword();
                            }),
                        5.ph,
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                                elevation: 0,
                                isScrollControlled: true,
                                const LoginScreen(
                                  isSignIn: false,
                                ));
                          },
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Forgot Password',
                              style: kRegularTextStyle,
                            ),
                          ),
                        ),
                        30.ph,
                      ],
                    )),
                    controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: ColorRes.mainButtonColor,
                            ),
                          )
                        : CustomGeneralButton(
                            onTab: () {
                              Get.log(mailOrNumber);
                              controller.login(isNumber, mailOrNumber);
                            },
                            title: "Sign In",
                            // width: 195
                          ),
                    20.ph,
                    //  commonBetaVersionEmail(),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
