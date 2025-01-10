import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/domain/entities/refer/refer_project_response.dart';
import 'package:marathon/domain/entities/refer/refer_response.dart';
import 'package:marathon/domain/use_cases/refer_use_case/refer_use_case.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data/server/api/api_const.dart';
import '../../../data/storage/app/app_holder.dart';
import '../../../data/tools/toast/custom_snackbar.dart';
import '../../../domain/use_cases/refer_use_case/refer_project_use_case.dart';
import '../../mainController/main_controller.dart';

///REFER CONTROLLER
class ReferController extends BaseController {
  int maxLines = 4;
  List<Contact> contacts = [];
  bool contactListLoading = false;
  bool permissionDenied = false;
  List<bool>? checkValue;
  List<Contact> selectedContact = [];
  List<Contact> searchContact = [];
  TextEditingController searchController = TextEditingController();
  MainController mainController = MainController();
  bool isDialogShowing = false;
  String? selectProject;
  ReferUseCase referUseCase;
  ReferResponse? referResponse;
  ReferProjectUseCase referProjectUseCase;
  ReferProjectResponse? referProjectResponse;
  bool isLoading = false;

  List<String> projectName = [
    "Monte South",
    "Monte Carlo",
    "Millennia",
    "Nextown",
    "Nexzone",
    "Nexworld",
    "NeoHomes",
    "Emblem",
    "Nagari NX"
  ];

  List openIndex = [];
  void openTab(index) {
    if (openIndex.contains(index)) {
      openIndex.remove(index);
    } else {
      openIndex.add(index);
    }
    update();
  }

  ReferController(
    this.referUseCase,
    this.referProjectUseCase,
  );

  @override
  void onInit() {
    fetchContact();
    getReferProject();
    super.onInit();
  }

  bool isSearch = false;

  setIsSearch(bool value) {
    isSearch = value;
    update();
  }

  void fetchContact() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      permissionDenied = true;
      update();
    } else {
      contactListLoading = true;
      final contact = await FlutterContacts.getContacts(withProperties: true);
      contacts = contact;
      checkValue = List.generate(contacts.length, (index) => false);
      update();
      contactListLoading = false;
      update();
    }
  }

  void checkBoxValue(int index, value) {
    checkValue?[index] = value;
    update();
  }

  onTab() {
    if (maxLines == 1000) {
      maxLines = 4;
      update();
    } else {
      maxLines = 1000;
      update();
    }
  }

  void referData({String? lastName, String? mobile}) {
    Map<String, dynamic> request = {
      "last_name": lastName,
      "project": selectProject,
      "mobile": mobile,
      "referrer_name": Get.find<AppHolder>().name,
      "referrer_mobile": Get.find<AppHolder>().number,
    };
    log('ReferRequest==========>>>>>$request');
    referUseCase.invoke(request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.status == 'success') {
          referResponse = response;
          update();
          log('response==========>>>>>$response');
          update();
        } else {
          customSnackBar(response?.status);
        }
      }, error: (error) {
        customSnackBar(error.toString());
      });
    })
      ..onDone(() async {
        isLoading = false;
        update();
      })
      ..addTo(subscribe);
  }

  void getReferProject() {
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "refer_projects"
    };
    log('params ---------->>>>>>>> $params');
    // int diff = 0;
    // if (Get.find<AppHolder>().localDate != "") {
    //   var startTime = DateTime.parse(Get.find<AppHolder>().localDate ?? "");
    //   var currentTime = DateTime.now();
    //   diff = currentTime.difference(startTime).inHours;
    // }

    referProjectUseCase.invoke(params).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        referProjectResponse = response;
        log('response==========>>>>>$response');
        log('referProjectResponse==========>>>>>${referProjectResponse?.data}');
        log('referProjectResponse==========>>>>>${referProjectResponse?.status}');
        update();
      }, error: (error) {
        customSnackBar(error.toString());
      });
    })
      ..onDone(() async {
        isLoading = false;
        update();
      })
      ..addTo(subscribe);
  }
}
