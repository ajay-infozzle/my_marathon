import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/view/main_page/main_page.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !Get.find<AppHolder>().isOpenFromNotification,
      onPopInvokedWithResult: (didPop, result) {
        if(Get.find<AppHolder>().isOpenFromNotification){
          Get.find<AppHolder>().isOpenFromNotification = false;
          Get.find<AppHolder>().screenOpenViaNotification = "";
          Get.offAll(() => const MainPage());
        }
      },
      // onPopInvoked: (didPop) {
      //   if(Get.find<AppHolder>().isOpenFromNotification){
      //     Get.find<AppHolder>().isOpenFromNotification = false;
      //     Get.find<AppHolder>().screenOpenViaNotification = "";
      //     Get.offAll(() => const MainPage());
      //   }
      // },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Get.find<AppHolder>().isOpenFromNotification) {
                Get.find<AppHolder>().isOpenFromNotification = false;
                Get.find<AppHolder>().screenOpenViaNotification = "";
                Get.offAll(() => const MainPage());
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: const Placeholder(),
      ),
    );
  }
}