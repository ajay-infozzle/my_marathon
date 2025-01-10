import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/my_account/my_account_controller.dart';
import '../../../../data/storage/app/app_holder.dart';
import '../../../../data/tools/constants/app_assets.dart';
import '../../../../data/tools/decoration/res_colors.dart';
import '../../../../data/tools/decoration/style_res.dart';
import '../../../widgets/common_whtasapp_button.dart';
import '../../../widgets/custom_general_button.dart';
import '../drawer/drawer.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<MyAccountController>(
        init: MyAccountController(Get.find()),
        builder: (controller) {
          return Scaffold(
            key: controller.mainController.scaffoldKey,
            resizeToAvoidBottomInset: false,
            floatingActionButton: commonFloatingActionButton(),
            endDrawer: const Drawer(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
              )),
              child: HomeDrawer(),
            ),
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
              actions: [
                IconButton(
                    onPressed: () {
                      controller.mainController.scaffoldKey.currentState
                          ?.openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      color: ColorRes.white,
                    ))
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                  child: Text(
                    textAlign: TextAlign.start,
                    "My Account",
                    style: kRegularThemeTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.mainButtonColor),
                  ),
                ),
                SizedBox(height: h * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04, vertical: h * 0.01),
                  child: Row(
                    children: [
                      const Icon(Icons.email_rounded,
                          color: ColorRes.mainButtonColor),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.02),
                        child: Text("Email",
                            style: kRegularTextStyle.copyWith(
                                fontWeight: FontWeight.w600)),
                      ),
                      const Spacer(),
                      Text(Get.find<AppHolder>().email,
                          style: kRegularTextStyle.copyWith(
                              fontSize: 14, color: ColorRes.greyTextColor1)),
                    ],
                  ),
                ),
                const Divider(color: ColorRes.greyD3),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04, vertical: h * 0.01),
                  child: Row(
                    children: [
                      const Icon(Icons.phone, color: ColorRes.mainButtonColor),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.02),
                        child: Text("Mobile No.",
                            style: kRegularTextStyle.copyWith(
                                fontWeight: FontWeight.w600)),
                      ),
                      const Spacer(),
                      Text(Get.find<AppHolder>().number,
                          style: kRegularTextStyle.copyWith(
                              fontSize: 14, color: ColorRes.greyTextColor1)),
                    ],
                  ),
                ),
                const Divider(color: ColorRes.greyD3),
                SizedBox(height: h * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                  child: GestureDetector(
                    onTap: () {
                      deleteBottomSheet(context: context);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.icon.profileDeleteIcon,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.02),
                          child: Text("Delete Account",
                              style: kRegularTextStyle.copyWith(
                                  color: ColorRes.red,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                // commonBetaVersionEmail(),
                SizedBox(height: h * 0.02),
              ],
            ),
          );
        });
  }

  Future<dynamic> deleteBottomSheet({
    required BuildContext context,
  }) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
        //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (BuildContext context) {
          return GetBuilder<MyAccountController>(
              init: MyAccountController(Get.find()),
              builder: (controller) {
                return IntrinsicHeight(
                  child: Container(
                    // height: h * 0.35,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: h * 0.02),
                        Container(
                          height: h * 0.008,
                          width: w * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(height: h * 0.03),
                        SvgPicture.asset(
                          AppAssets.icon.warningIcon,
                        ),
                        SizedBox(height: h * 0.02),
                        Text(
                          "Are you sure ?",
                          style: kRegularTextStyle.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        SizedBox(height: h * 0.01),
                        Text(
                            'If you’re sure you want to proceed,\n click "Delete Account" below.',
                            textAlign: TextAlign.center,
                            style: kRegularTextStyle.copyWith(
                                fontSize: 14, color: ColorRes.greyTextColor1)),
                        SizedBox(height: h * 0.04),
                        Center(
                          child: controller.isLoading == true
                              ? const CircularProgressIndicator(
                                  color: ColorRes.mainButtonColor)
                              : CustomGeneralButton(
                                  onTab: () {
                                    controller.myAccountDelete();
                                  },
                                  title: "Delete Account",
                                ),
                        ),
                        SizedBox(height: h * 0.03),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
