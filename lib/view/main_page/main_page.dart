import 'dart:developer';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/mainController/main_controller.dart';
import 'package:marathon/data/services/analytics_service.dart';
import 'package:marathon/data/tools/constants/app_assets.dart';
import 'package:marathon/data/tools/decoration/res_colors.dart';
import 'package:marathon/data/tools/toast/custom_snackbar.dart';
import 'package:marathon/view/widgets/svg_view.dart';
import '../widgets/common_whtasapp_button.dart';
import 'home/drawer/drawer.dart';

class MainPage extends StatefulWidget {
  final bool isSignIn;

  const MainPage({super.key, this.isSignIn = false});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<MainController>().isSignIn = widget.isSignIn;
      // await FirebaseAnalytics.instance
      //     .setUserId(id: Get.find<AppHolder>().id.toString());
      /*await analytics.logEvent(
        name: 'main_screen',
        parameters: {
          'screen': 'main_screen',
        },
      );*/
    });
    super.initState();
    AnalyticsService.instance.onHomeScreenView();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    log('AppAssets.icon.marathonLogo==========>>>>>${AppAssets.icon.marathonLogo}');
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: commonFloatingActionButton(),
            key: controller.scaffoldKey,
            endDrawer: const Drawer(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
              )),
              child: HomeDrawer(isHome: true),
            ),
            appBar: AppBar(
              backgroundColor: ColorRes.mainButtonColor,
              leading: controller.currentIndex == 0
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () {
                        if (controller.currentIndex != 0) {
                          controller.changePage(0, isBack: true);
                        } else {
                          customSnackBar("double tap to exit");
                        }
                      },
                      onDoubleTap: () {
                        exit(1);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: ColorRes.white,
                      ),
                    ),
              centerTitle: true,
              title: SvgPicture.asset(AppAssets.icon.marathonLogo,
                  // ignore: deprecated_member_use
                  color: Colors.white, width: 171, height: 22),
              // Image(
              //   image: AssetImage(AppAssets.images.logoMarathon),
              //   width: 171,
              // ),
              actions: [
                IconButton(
                    onPressed: () {
                      controller.scaffoldKey.currentState!.openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      color: ColorRes.white,
                    ))
              ],
            ),
            bottomNavigationBar: controller.isApartment
                ? IntrinsicHeight(
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: ColorRes.mainButtonColor,
                                  width: 1.5))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.05,
                            vertical: Platform.isAndroid
                                ? Get.height * 0.01
                                : Get.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            5,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.changePage(index);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: Platform.isAndroid
                                          ? h * 0.035
                                          : h * 0.033,
                                      width: Platform.isAndroid
                                          ? h * 0.035
                                          : h * 0.033,
                                      child: SvgView(
                                        imageUrl: controller.bottomData[index]
                                            ['image'],
                                        height: Platform.isAndroid
                                            ? h * 0.035
                                            : h * 0.033,
                                        width: Platform.isAndroid
                                            ? h * 0.035
                                            : h * 0.033,
                                        color: controller.currentIndex == index
                                            ? ColorRes.mainButtonColor
                                            : ColorRes.grey,
                                      ),
                                    ),
                                    Text(
                                      "${controller.bottomData[index]['title']}",
                                      style: TextStyle(
                                          color:
                                              controller.currentIndex == index
                                                  ? ColorRes.mainButtonColor
                                                  : ColorRes.grey,
                                          fontSize: Platform.isAndroid
                                              ? Get.width * 0.035
                                              : Get.width * 0.033),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: ColorRes.mainButtonColor, width: 1.5))),
                    child: BottomNavigationBar(
                      elevation: 0,
                      selectedItemColor: ColorRes.mainButtonColor,
                      unselectedItemColor: Colors.grey,
                      currentIndex: controller.currentIndex,
                      type: BottomNavigationBarType.fixed,
                      onTap: (value) {
                        controller.changePage(value);
                      },
                      items: [
                        BottomNavigationBarItem(
                            icon: SvgView(
                              imageUrl: AppAssets.icon.home,
                              height: 32,
                              width: 32,
                              color: controller.currentIndex == 0
                                  ? ColorRes.mainButtonColor
                                  : ColorRes.grey,
                            ),
                            label: "Home"),
                        BottomNavigationBarItem(
                            icon: SvgView(
                              imageUrl: AppAssets.icon.support,
                              height: 31,
                              width: 31,
                              color: (controller.pages.length == 2 &&
                                          controller.currentIndex == 1) ||
                                      controller.currentIndex == 3
                                  ? ColorRes.mainButtonColor
                                  : ColorRes.grey,
                            ),
                            label: "Support"),
                      ],
                    ),
                  ),
            body: PageView(
              controller: controller.controller,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(controller.pages.length, (index) {
                return controller.pages[index];
              }),
            ),
          );
        });
  }
}
