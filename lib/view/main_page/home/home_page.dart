import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/home/home_conroller.dart';
import 'package:marathon/data/tools/decoration/res_colors.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/main_page/home/widgets/home_item.dart';
import '../../../data/tools/decoration/style_res.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(Get.find()),
        builder: (controller) {
          return Scaffold(
            body: controller.isLoading == false
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width / 5, vertical: 20),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Select the Apartment you want to view",
                            style: kRegularThemeTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: ColorRes.black),
                          ),
                        ),
                        for (int i = 0; i < controller.length; i++)
                          HomeItem(
                            title: controller.apartmentsList?.data
                                    ?.apartments?[i].title ??
                                "",
                            building: controller.apartmentsList?.data
                                    ?.apartments?[i].building ??
                                "",
                            img: controller
                                    .apartmentsList?.data?.apartments?[i].img ??
                                "",
                            project: controller.apartmentsList?.data
                                    ?.apartments?[i].project ??
                                "",
                            id: controller.apartmentsList?.data?.apartments?[i]
                                    .apartmentId ??
                                "0",
                          ),
                        20.ph,
                        // commonBetaVersionEmail(),
                        // 20.ph,
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }
}
