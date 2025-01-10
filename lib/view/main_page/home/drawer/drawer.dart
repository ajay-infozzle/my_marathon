import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/mainController/main_controller.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/data/tools/constants/app_assets.dart';
import 'package:marathon/data/tools/decoration/style_res.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/auth_pages/change_password/change_password.dart';
import 'package:marathon/view/splash/splash_page.dart';
import 'package:marathon/view/widgets/svg_view.dart';
import '../../../../data/tools/decoration/res_colors.dart';
import '../my_account/my_account_page.dart';

class HomeDrawer extends StatelessWidget {
  final bool isHome;
  const HomeDrawer({super.key, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.drawerBackground,
        body: Column(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 65, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        backgroundImage: AssetImage(AppAssets.images.avatar)),
                    5.ph,
                    Text(
                      Get.find<AppHolder>().name,
                      style: kBoldThemeTextStyle.copyWith(fontSize: 16),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 35),
                      child: Divider(),
                    )
                  ],
                ),
              )
            ],
          ),
          DrawerTales(
            title: 'Home',
            onTab: () {
              if (!isHome) {
                Get.back();
              }
              Get.find<MainController>().changePage(0);
              Get.back();
            },
            imgUrl: AppAssets.icon.homee,
          ),
          4.ph,
          DrawerTales(
            title: 'My Account',
            onTab: () {
              Get.back();
              Get.to(() => const MyAccountPage());
            },
            imgUrl: AppAssets.icon.profile,
          ),
          4.ph,
          Visibility(
            visible: Get.find<MainController>().isApartment,
            child: DrawerTales(
              title: 'Payments',
              onTab: () {
                if (!isHome) {
                  Get.back();
                }
                Get.find<MainController>().changePage(1);
                Get.back();
              },
              imgUrl: AppAssets.icon.payment,
            ),
          ),
          4.ph,
          Visibility(
            visible: Get.find<MainController>().isApartment,
            child: DrawerTales(
              title: 'Document',
              onTab: () {
                if (!isHome) {
                  Get.back();
                }
                Get.find<MainController>().changePage(2);
                Get.back();
              },
              imgUrl: AppAssets.icon.document,
            ),
          ),
          4.ph,
          DrawerTales(
            title: 'Support',
            onTab: () {
              if (!isHome) {
                Get.back();
              }
              Get.find<MainController>().changePage(
                  Get.find<MainController>().pages.length == 2 ? 1 : 3);
              Get.back();
            },
            imgUrl: AppAssets.icon.supportt,
          ),
          4.ph,
          Visibility(
            visible: Get.find<MainController>().isApartment,
            child: DrawerTales(
              title: 'Refer',
              onTab: () {
                if (!isHome) {
                  Get.back();
                }
                Get.find<MainController>().changePage(4);
                Get.back();
              },
              imgUrl: AppAssets.icon.health,
            ),
          ),
          4.ph,
          DrawerTales(
            title: 'Change Password',
            onTab: () {
              Get.back();
              Get.bottomSheet(
                  isScrollControlled: true, const ChangePasswordPage());
            },
          ),
          4.ph,
          if (Get.find<AppHolder>().isSwitch)
            DrawerTales(
                title: 'Switch Apartment',
                onTab: () {
                  Get.back();
                  Get.find<AppHolder>().localDate = "";
                  Get.find<MainController>().isApartment = true;
                  Get.find<MainController>().changePages("0");
                  Get.find<MainController>().changePage(0, isBack: true);
                  Get.find<MainController>().update();
                }),
          DrawerTales(
            iconButton: false,
            title: 'Sign Out',
            onTab: () {
              Get.find<AppHolder>().clearAuth();
              Get.offAll(() => const SplashPage());
            },
          ),

          // const Spacer(),
          // InkWell(
          //   onTap: () {
          //     Get.find<AppHolder>().clearAuth();
          //     Get.offAll(() => const SplashPage());
          //   },
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          //     height: 61,
          //     width: double.infinity,
          //     color: ColorRes.mainButtonColor,
          //     child: const Text(
          //       "Sign Out",
          //       style: kRegularWhiteTextStyle,
          //     ),
          //   ),
          // )
        ]));
  }
}

class DrawerTales extends StatelessWidget {
  final String? imgUrl;
  final String title;
  final Function onTab;
  final bool iconButton;
  const DrawerTales(
      {super.key,
      required this.title,
      required this.onTab,
      this.imgUrl,
      this.iconButton = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTab();
      },
      child: Container(
          height: 48,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: ColorRes.drawerBackground,
            boxShadow: [
              BoxShadow(
                color: ColorRes.greyD3,
                spreadRadius: 1,
                blurRadius: 0,
                offset: Offset(0.5, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              40.pw,
              imgUrl == null
                  ? 0.pw
                  : SizedBox(
                      width: 20,
                      height: 20,
                      child: SvgView(
                        height: 15,
                        width: 15,
                        imageUrl: imgUrl ?? "",
                        color: ColorRes.mainButtonColor,
                      ),
                    ),
              10.pw,
              Text(
                title,
                style: kRegularTextStyle,
              ),
              const Spacer(),
              iconButton == true
                  ? IconButton(
                      onPressed: () {}, icon: const Icon(Icons.navigate_next))
                  : const SizedBox(),
            ],
          )),
    );
  }
}
