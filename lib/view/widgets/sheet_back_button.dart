import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/tools/decoration/res_colors.dart';

class SheetBackButton extends StatelessWidget {
 final bool scrollable;
  const SheetBackButton({
    super.key,  this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return scrollable?SizedBox(
      height: 200,
      child: Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 53),
        height: 34,
        width: 34,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorRes.white)),
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: ColorRes.white,
              size: 16,
            )),
      ),
    ),): Expanded(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 16, top: 53),
            height: 34,
            width: 34,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorRes.white)),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: ColorRes.white,
                  size: 16,
                )),
          ),
        ));
  }
}