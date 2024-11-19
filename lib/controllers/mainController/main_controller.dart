import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/controllers/document/document_controller.dart';
import 'package:marathon/controllers/home/payments/payments_controller.dart';
import 'package:marathon/controllers/support_controller/support_controller.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/data/storage/app/app_prefs.dart';
import 'package:marathon/view/main_page/documents/documents.dart';
import 'package:marathon/view/main_page/home/apartment/apartment_details_page.dart';
import 'package:marathon/view/main_page/payments_page/payments_page.dart';
import '../../data/tools/constants/app_assets.dart';
import '../../view/main_page/home/home_page.dart';
import '../../view/main_page/home/refer/refer_page.dart';
import '../../view/main_page/support/support_page.dart';
import '../home/apartment_details_controller/apartment_controller.dart';

class MainController extends BaseController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int homePageIndex = 0;
  int currentIndex = 0;
  late PageController controller;
  bool isApartment = false;
  bool isSignIn = false;
  String apartmentId = "";
  List<Widget> pages = [];
  List pagesIndex = [0];
  List<Map<String, dynamic>> bottomData = [
    {'image': AppAssets.icon.home, 'title': "Home"},
    {'image': AppAssets.icon.payment, 'title': "Payments"},
    {'image': AppAssets.icon.documentt, 'title': "Documents"},
    {'image': AppAssets.icon.support, 'title': "Support"},
    {'image': AppAssets.icon.health, 'title': "Refer"},
  ];
  @override
  void onInit() {
    pages = [const HomePage(), const SupportPage()];
    controller = PageController(initialPage: currentIndex);
    super.onInit();
  }

  void changePages(
    String id,
  ) {
    if (isApartment == false) {
      isApartment = true;
      if (isSignIn) {
        Get.find<ApartmentController>().isSignIn = true;
      }
      pages = [
        ApartmentDetails(
          id: id,
        ),
        const PaymentsPage(),
        const DocumentsPage(),
        const SupportPage(),
        const ReferPage(),
      ];

      apartmentId = id;
      Get.find<ApartmentController>().getApartmentDetail(id);
      Get.find<ApartmentController>().getAllProject();
      Get.find<ApartmentController>().getLedgerDetail();
      Get.find<DocumentController>().getApartmentDetail(id);
      Get.find<PaymentsController>().getApartmentDetail();
      Get.find<SupportController>().getFaqData();
    } else {
      pages = [const HomePage(), const SupportPage()];
      isApartment = false;
    }
    update();
  }

  void changePage(int value, {bool isBack = false}) {
    Get.find<ApartmentController>().isSignIn = false;
    Get.log(value.toString());
    Get.log(pagesIndex.toString());
    currentIndex = value;
    update();
    if (isBack) {
      currentIndex = 0;
    }
    controller.jumpToPage(currentIndex);
    // controller.animateToPage(currentIndex,
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.fastOutSlowIn);
    update();
  }
}
