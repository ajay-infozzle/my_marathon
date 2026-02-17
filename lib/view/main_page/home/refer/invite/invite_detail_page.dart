import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/home/refer_controller/refer_controller.dart';
import 'package:marathon/data/services/analytics_service.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import '../../../../../data/tools/constants/app_assets.dart';
import '../../../../../data/tools/decoration/dimens.dart';
import '../../../../../data/tools/decoration/res_colors.dart';
import '../../../../../data/tools/decoration/style_res.dart';
import '../../../../widgets/common_whtasapp_button.dart';
import '../../../../widgets/custom_general_button.dart';

class InviteDetailPage extends StatefulWidget {

  const InviteDetailPage({
    super.key,
  });

  @override
  State<InviteDetailPage> createState() => _InviteDetailPageState();
}

class _InviteDetailPageState extends State<InviteDetailPage> {

  ReferController referController = Get.find();

  @override
  void initState() {
    log('referController.selectProject==========>>>>>${referController.selectProject}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top:false,
      child: Scaffold(
        floatingActionButton: commonFloatingActionButton(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorRes.mainButtonColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ColorRes.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: SvgPicture.asset(AppAssets.icon.marathonLogo,
              // ignore: deprecated_member_use
              color: Colors.white, width: 171, height: 22),
        ),
        body: GetBuilder<ReferController>(
            init: ReferController(Get.find(), Get.find()),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.ph,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.padding),
                      child: Text(
                        textAlign: TextAlign.start,
                        "Invite & Earn Rewards ",
                        style: kRegularThemeTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.mainButtonColor),
                      ),
                    ),
                    20.ph,
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.selectedContact.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimens.padding),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .selectedContact[i].displayName,
                                          style: kRegularThemeTextStyle.copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: ColorRes.mainTextColor),
                                        ),
                                        2.ph,
                                        Text(
                                          controller.selectedContact[i].phones
                                                  .isEmpty
                                              ? ""
                                              : controller.selectedContact[i]
                                                  .phones.first.normalizedNumber,
                                          style: kRegularThemeTextStyle.copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: ColorRes.mainTextColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(color: ColorRes.greyD3),
                              ],
                            ),
                          );
                        }),
                    25.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                            text:
                                'By submitting your references you are accepting our ',
                            style: kSemiBoldTextStyle.copyWith(fontSize: 14),
                          ),
                          TextSpan(
                            text: 'terms and conditions.',
                            style: kSemiBoldTextStyle.copyWith(
                                fontSize: 14,
                                decoration: TextDecoration.underline),
                          ),
                          TextSpan(
                            text:
                                'We will be contacting your references shortly.',
                            style: kSemiBoldTextStyle.copyWith(fontSize: 14),
                          ),
                        ]),
                      ),
                    ),
                    30.ph,
                    Center(
                      child: CustomGeneralButton(
                        onTab: () {
                          AnalyticsService.instance.onReferred();
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              Future.delayed(const Duration(seconds: 3), () {
                                Get.back();
                                Get.back();
                                Get.back();
                              });
                              return Dialog(
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: ColorRes.mainButtonColor,
                                          width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: const BoxDecoration(
                                              color: ColorRes.greyColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: ColorRes.greyD3,
                                                  spreadRadius: 0,
                                                  blurRadius: 10,
                                                  offset: Offset(0, 8),
                                                ),
                                              ],
                                              shape: BoxShape.circle),
                                          child: Image.asset(
                                            AppAssets.images.like,
                                            scale: 1.2,
                                            // height: 10,
                                            // width: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          textAlign: TextAlign.center,
                                          "Thank you for sharing.\nWe're grateful for your referral!",
                                          style: kRegularThemeTextStyle.copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: ColorRes.mainTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                          
                          // ignore: avoid_function_literals_in_foreach_calls
                          controller.selectedContact.forEach((element) {
                            if (controller.selectedContact.contains(element)) {
                              log('element==========>>>>>$element');
                              if (element.phones.isNotEmpty) {
                                controller.referData(
                                    lastName: element.displayName,
                                    mobile: element.phones.isEmpty
                                        ? ""
                                        : element.phones.first.normalizedNumber);
                              }
                            }
                          });
                        },
                        title: "Invite",
                        //  verticalPadding: 3,
                      ),
                    ),
                    // 20.ph,
                    // commonBetaVersionEmail(),
                    30.ph,
                  ],
                ),
              );
            }),
      ),
    );
  }
}
