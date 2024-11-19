import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../decoration/res_colors.dart';

void customSnackBar(String? message) {
  Get.snackbar('', "",
      backgroundColor: ColorRes.defaultGrey,
      titleText: Text(
        message?.isNotEmpty == true ? message! : 'Incorrect Password'.tr,
        style: const TextStyle(
            fontSize: 14, color: ColorRes.black, fontWeight: FontWeight.bold),
      ),
      messageText: const SizedBox.shrink());
}
