import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/mainController/main_controller.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/widgets/net_image.dart';

import '../../../../data/tools/decoration/dimens.dart';
import '../../../../data/tools/decoration/res_colors.dart';
import '../../../../data/tools/decoration/style_res.dart';
import '../../../widgets/custom_general_button.dart';

class HomeItem extends StatelessWidget {
  final String title;
  final String img;
  final String project;
  final String building;
  final String id;
  const HomeItem({
    super.key,
    required this.title,
    required this.img,
    required this.project,
    required this.building,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.all(Dimens.padding),
        width: double.maxFinite,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: ColorRes.greyD3,
                spreadRadius: 1,
                blurRadius: 0,
                offset: Offset(0, 1.5), // changes position of shadow
              ),
            ],
            color: ColorRes.listItemColors,
            borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              NetImageView(imageUrl: img, name: ''),
              16.pw,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      project,
                      style: kRegularThemeTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorRes.mainTextColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                    ),
                    3.ph,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        textAlign: TextAlign.start,
                        building,
                        maxLines: 3,
                        style: kRegularThemeTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.mainTextColor),
                      ),
                    ),
                    3.ph,
                    Text(
                      textAlign: TextAlign.center,
                      title,
                      style: kRegularThemeTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorRes.mainTextColor),
                    ),
                    3.ph,
                    CustomGeneralButton(
                      onTab: () {
                        log("clicked on view button--> $id");
                        Get.find<MainController>().apartmentId = id;
                        Get.find<MainController>().changePages(id);
                        Get.find<AppHolder>().localDate = "";
                      },
                      title: 'View',
                     // verticalPadding: 3,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
