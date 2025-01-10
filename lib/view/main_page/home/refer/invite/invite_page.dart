import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/home/refer_controller/refer_controller.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/data/tools/toast/custom_snackbar.dart';
import '../../../../../data/tools/constants/app_assets.dart';
import '../../../../../data/tools/decoration/dimens.dart';
import '../../../../../data/tools/decoration/res_colors.dart';
import '../../../../../data/tools/decoration/style_res.dart';
import '../../../../widgets/common_whtasapp_button.dart';
import '../../../../widgets/custom_general_button.dart';
import '../../drawer/drawer.dart';
import 'invite_detail_page.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({super.key});

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<ReferController>(
        init: ReferController(Get.find(), Get.find()),
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.padding),
                  child: Text(
                    textAlign: TextAlign.start,
                    "Select the contacts you would like to refer to our projects",
                    style: kRegularThemeTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: h * 0.02, left: w * 0.042, right: w * 0.042),
                  alignment: Alignment.center,
                  //height: 35,
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
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimens.buttonRadius),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.055,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              value: controller.selectProject,
                              style: kRegularThemeTextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              items: controller.referProjectResponse?.data
                                  ?.map((String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ));
                              }).toList(),
                              hint: Text(
                                'Select Project',
                                style: kRegularThemeTextStyle.copyWith(
                                    color: ColorRes.hintColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              onChanged: (value) {
                                controller.selectProject = value!;
                                log('value==========>>>>>$value');
                                controller.update();
                              },
                            ),
                          ),
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  height: 35,
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
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimens.buttonRadius),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: controller.searchController,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    controller.setIsSearch(false);
                                    controller.searchContact.clear();
                                    controller.checkValue = List.generate(
                                        controller.contacts.length,
                                        (index) => false);
                                    for (int i = 0;
                                        i < controller.contacts.length;
                                        i++) {
                                      if (controller.selectedContact
                                          .contains(controller.contacts[i])) {
                                        controller.checkValue!.removeAt(
                                          i,
                                        );
                                        controller.checkValue!.insert(i, true);
                                      }
                                    }
                                  } else {
                                    controller.setIsSearch(true);
                                    controller.searchContact.clear();
                                    for (var element in controller.contacts) {
                                      if (element.displayName
                                              .toLowerCase()
                                              .contains(value) ||
                                          (element.phones.isNotEmpty
                                              ? element
                                                  .phones.first.normalizedNumber
                                                  .toLowerCase()
                                                  .contains(value)
                                              : "".contains(value))) {
                                        controller.searchContact.add(element);
                                      }
                                    }
                                    if (controller.searchContact.isNotEmpty) {
                                      controller.checkValue = List.generate(
                                          controller.searchContact.length,
                                          (index) => false);
                                      for (int i = 0;
                                          i < controller.searchContact.length;
                                          i++) {
                                        if (controller.selectedContact.contains(
                                            controller.searchContact[i])) {
                                          controller.checkValue!.removeAt(
                                            i,
                                          );
                                          controller.checkValue!
                                              .insert(i, true);
                                        }
                                      }
                                    }
                                  }
                                  controller.update();
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search name or number",
                                    hintStyle: kRegularTextStyle.copyWith(
                                        fontSize: 16,
                                        color: ColorRes.hintColor,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            const Icon(
                              Icons.search_rounded,
                              color: ColorRes.hintColor,
                            )
                          ],
                        ),
                      )),
                ),
                10.ph,
                if (controller.permissionDenied)
                  const Center(child: Text('Permission denied')),
                if (controller.contactListLoading == true)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.16),
                        child: const CircularProgressIndicator(),
                      )),
                    ],
                  ),
                if (controller.contacts.isEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.25),
                        child: const Text("No Contacts in the Phone"),
                      )),
                    ],
                  ),
                controller.isSearch && controller.searchContact.isEmpty
                    ? Center(
                        child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.26),
                        child: const Text("No Contact Found"),
                      ))
                    : Expanded(
                        child: ListView.builder(
                            itemCount: controller.isSearch
                                ? controller.searchContact.length
                                : controller.contacts.length,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  CheckboxListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal: -3, vertical: -4),
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: controller.checkValue![i],
                                    onChanged: (value) {
                                      controller.checkValue![i] = value!;
                                      if (controller.checkValue![i] == true) {
                                        controller.selectedContact.add(
                                            controller.isSearch
                                                ? controller.searchContact[i]
                                                : controller.contacts[i]);
                                      } else {
                                        controller.selectedContact.remove(
                                            controller.isSearch
                                                ? controller.searchContact[i]
                                                : controller.contacts[i]);
                                      }
                                      controller.update();
                                    },
                                    side: const BorderSide(
                                        color: ColorRes.mainButtonColor),
                                    activeColor: ColorRes.white,
                                    checkColor: ColorRes.white,
                                    fillColor: WidgetStatePropertyAll(
                                        controller.checkValue![i] == true
                                            ? ColorRes.mainButtonColor
                                            : ColorRes.white),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    title: Text(
                                      controller.isSearch
                                          ? controller
                                              .searchContact[i].displayName
                                          : controller.contacts[i].displayName,
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: ColorRes.mainTextColor),
                                    ),
                                    subtitle: Text(
                                      controller.isSearch
                                          ? controller.searchContact[i].phones
                                                  .isEmpty
                                              ? ""
                                              : controller.searchContact[i]
                                                  .phones.first.normalizedNumber
                                          : controller
                                                  .contacts[i].phones.isEmpty
                                              ? ""
                                              : controller.contacts[i].phones
                                                  .first.normalizedNumber,
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: ColorRes.mainTextColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, right: 10),
                                    child: Divider(
                                      color: ColorRes.greyD3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                10.ph,
                Center(
                  child: CustomGeneralButton(
                    onTab: () async {
                      if (controller.selectProject == null) {
                        customSnackBar("Please select Project");
                      } else if (controller.selectedContact.isEmpty) {
                        customSnackBar("Please select contact");
                      } else {
                        Get.to(
                          () => const InviteDetailPage(),
                          arguments: controller.selectedContact,
                        );
                      }
                    },
                    title: "Next",
                    //  verticalPadding: 3,
                  ),
                ),
                10.ph,
                // commonBetaVersionEmail(),
                // 10.ph,
              ],
            ),
          );
        });
  }
}
