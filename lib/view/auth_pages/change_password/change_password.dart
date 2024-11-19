import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/auth/authController.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import 'package:marathon/view/widgets/sheet_back_button.dart';
import '../../../data/tools/decoration/dimens.dart';
import '../../../data/tools/decoration/res_colors.dart';
import '../../../data/tools/decoration/style_res.dart';
import '../../widgets/common_beta_version_email.dart';
import '../../widgets/custom_textfield.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(Get.find()),
        builder: (controller) {
          return Column(
            children: [
              const SheetBackButton(),
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
                  children: [
                    10.ph,
                    Text(
                      "Change Password",
                      style: kRegularThemeTextStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    20.ph,
                    Visibility(
                        visible: true,
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width,
                              child: Text(
                                'Current Password',
                                style: kRegularWhiteTextStyle.copyWith(
                                    fontSize: 20,
                                    color: ColorRes.mainTextColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            CustomTextField(
                                textEditingController:
                                    controller.numberController,
                                onChanged: (v) {},
                                visible: controller.passwordVisible,
                                tapToHide: () {
                                  controller.hidePassword();
                                }),
                            25.ph,
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
                                textEditingController:
                                    controller.passwordController,
                                onChanged: (v) {},
                                visible: controller.passwordVisible,
                                tapToHide: () {
                                  controller.hidePassword();
                                }),
                            25.ph,
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
                            25.ph,
                          ],
                        )),
                    CustomGeneralButton(
                      onTab: () {
                        controller.changePassword();
                      },
                      title: "Change Password",
                    ),
                    // const Spacer(),
                    // commonBetaVersionEmail(),
                     20.ph,
                  ],
                ),
              ),
            ],
          );
        });
  }
}
