import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:marathon/data/tools/decoration/res_colors.dart';
import '../../../controllers/terms_and_condition/terms_and_condition_controller.dart';
import '../../../data/tools/constants/app_assets.dart';
import '../../../data/tools/decoration/style_res.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({super.key});

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<TermsAndConditionController>(
          init: TermsAndConditionController(Get.find()),
          builder: (controller) {
            return controller.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                        color: ColorRes.mainButtonColor),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 0.03, vertical: h * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Terms and Condition",
                            style: kRegularThemeTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.mainButtonColor),
                          ),
                          Html(
                              data:"${controller.termsAndConditionResponse?.content}",
                              style: {
                                "body": Style(
                                  fontSize: FontSize(14),
                                  fontWeight: FontWeight.w400,
                                  color: ColorRes.black,
                                  fontFamily: AppFonts.fnproximanovaRegular,
                                ),
                              }),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
