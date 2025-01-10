import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_to_pdf_plus/html_to_pdf_plus.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/data/services/analytics_service.dart';
import 'package:marathon/data/tools/constants/app_assets.dart';
import 'package:marathon/domain/entities/all_project/all_project_response.dart';
import 'package:marathon/domain/entities/aparments/apartment_details/apartment_details_response.dart';
import 'package:marathon/domain/entities/ledge/ledger_details_response.dart';
import 'package:marathon/domain/use_cases/apartments_use_case/all_project_use_case/all_project_use_case.dart';
import 'package:marathon/domain/use_cases/apartments_use_case/details_use_case/get_apartment_details_use_case.dart';
import 'package:marathon/domain/use_cases/ledger_use_case/get_ledger_details_use_case.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/server/api/api_const.dart';
import '../../../data/storage/app/app_holder.dart';
import '../../../data/tools/toast/custom_snackbar.dart';
import '../../../domain/entities/message/message.dart';
import '../../../domain/use_cases/message_/message_use_case.dart';
import '../../mainController/main_controller.dart';

class ApartmentController extends BaseController {
  GetApartmentDetailsUseCase getApartmentDetailsUseCase;
  GetLedgerDetailsUseCase getLedgerDetailsUseCase;
  ApartmentDetailsResponse? apartmentDetailsResponse;
  LedgerDetailsResponse? ledgerDetailsResponse;

  AllProjectUseCase allProjectUseCase;
  AllProjectResponse? allProjectResponse;
  MessageUseCase messageUseCase;
  MessageData? messageData;
  int selectedStep = 4;
  bool isLoading = false;
  bool isSignIn = false;

  int l = 0;

  ApartmentController(this.getApartmentDetailsUseCase, this.messageUseCase,
      this.getLedgerDetailsUseCase, this.allProjectUseCase);

  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();

  Timer? _autoScrollTimer;
  Timer? _autoScrollTimer1;

  @override
  void onInit() {
    startAutoScroll();
    startAutoScroll1();
    super.onInit();
  }

  void startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (scrollController.hasClients) {
        double maxScrollExtent = scrollController.position.maxScrollExtent;
        double currentScrollPosition = scrollController.position.pixels;

        double newScrollPosition = currentScrollPosition + 200.0;
        if (newScrollPosition >= maxScrollExtent) {
          newScrollPosition = 0.0;
        }
        scrollController.animateTo(
          newScrollPosition,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  void startAutoScroll1() {
    _autoScrollTimer1 = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (scrollController1.hasClients) {
        double maxScrollExtent = scrollController1.position.maxScrollExtent;
        double currentScrollPosition = scrollController1.position.pixels;

        double newScrollPosition = currentScrollPosition + 200.0;
        if (newScrollPosition >= maxScrollExtent) {
          newScrollPosition = 0.0;
        }

        scrollController1.animateTo(
          newScrollPosition,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    scrollController.dispose();
    _autoScrollTimer1?.cancel();
    scrollController1.dispose();
    super.dispose();
  }

  List images = [AppAssets.images.image1, AppAssets.images.image2];

  List texts = [
    "Check the latest construction update",
    "Access Important Documents"
  ];

  List texts2 = [
    "Marathon Nextgen Realty Ltd Profits Soar by 218% YoY ",
    "Marathon Group & Adani Realty jointly develop luxury project in Mumbai"
  ];

  List images2 = [AppAssets.images.image3, AppAssets.images.image4];
  String? lastPendingEventName;
  String? lastPendingAmount;
  double totalPendingAmount = 0.0;
  bool pendingStatus = false;

  void getApartmentDetail(String id) {
    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "apartment_id": id,
      "fcm": Get.find<AppHolder>().fCMToken
    };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "apartment_get_details"
    };

    log('params ---------->>>>>>>> $params');
    log('request ---------->>>>>>>> $request');
    int diff = 0;
    log('Get.find<AppHolder>().localDate==========>>>>>${Get.find<AppHolder>().localDate}');

    if (Get.find<AppHolder>().localDate != "") {
      var startTime = DateTime.parse(Get.find<AppHolder>().localDate ?? "");
      var currentTime = DateTime.now();
      diff = currentTime.difference(startTime).inHours;
    }
    if (diff >= 5 || Get.find<AppHolder>().localDate == "") {
      Get.log(request.toString());
      getApartmentDetailsUseCase.invoke(params, request).listen((event) {
        event.when(loading: () {
          isLoading = true;
          update();
        }, content: (response) async {
          apartmentDetailsResponse = response;
          log('apartmentDetailsResponse==========>>>>>$apartmentDetailsResponse');
          final projectName = apartmentDetailsResponse
                  ?.data?.apartmentDetails?.firstOrNull?.projectName ??
              '';
          AnalyticsService.instance.onProjectName(projectName: projectName);

          // for (int i = 0; i < apartmentDetailsResponse!.data!.milestones!.length; i++) {
          //   var milestone = apartmentDetailsResponse?.data?.milestones?[i];
          //   if (milestone?.status == "Pending") {
          //     lastPendingEventName = milestone?.eventName;
          //     lastPendingAmount = milestone?.amount;
          //     totalPendingAmount += double.tryParse(milestone?.amount ?? '0') ?? 0.0;
          //   }
          //   else if (milestone?.status == "Partially Paid") {
          //     totalPendingAmount += double.tryParse(milestone?.outstandingAmt ?? '0') ?? 0.0;
          //   }
          // }

          for (int i = 0;
              i < apartmentDetailsResponse!.data!.milestones!.length;
              i++) {
            var milestone = apartmentDetailsResponse?.data?.milestones?[i];
            if (milestone?.status == "Pending") {
              lastPendingEventName = milestone?.eventName;
              lastPendingAmount = milestone?.amount;
              totalPendingAmount +=
                  double.tryParse(milestone?.amount ?? '0') ?? 0.0;
              pendingStatus = true;
            } else if (milestone?.status == "Partially Paid") {
              totalPendingAmount +=
                  double.tryParse(milestone?.outstandingAmt ?? '0') ?? 0.0;
            }
          }
          if (pendingStatus == false) {
            for (int i = 0;
                i < apartmentDetailsResponse!.data!.milestones!.length;
                i++) {
              var milestone = apartmentDetailsResponse?.data?.milestones?[i];
              if (milestone?.status == "Partially Paid") {
                lastPendingEventName = milestone?.eventName;
                lastPendingAmount = milestone?.amount;
              }
            }
          }
          Get.find<AppHolder>().homeData = jsonEncode(response).isNotEmpty ? jsonEncode(response) : "";
          Get.find<AppHolder>().localDate = DateTime.now().toString();
        }, error: (error) {
          customSnackBar(error.toString());
        });
      })
        ..onDone(() async {
          isLoading = false;
          update();
        })
        ..addTo(subscribe);
    } else {
      isLoading = true;
      update();
      log('homeData==========>>>>>${Get.find<AppHolder>().homeData!}');
      apartmentDetailsResponse = ApartmentDetailsResponse.fromJson(
          jsonDecode(Get.find<AppHolder>().homeData!));

      final projectName = apartmentDetailsResponse
              ?.data?.apartmentDetails?.firstOrNull?.projectName ??
          '';

      AnalyticsService.instance.onProjectName(projectName: projectName);

      // for (int i = 0; i < apartmentDetailsResponse!.data!.milestones!.length; i++) {
      //   var milestone = apartmentDetailsResponse?.data?.milestones?[i];
      //   if (milestone?.status == "Pending") {
      //     lastPendingEventName = milestone?.eventName;
      //     lastPendingAmount = milestone?.amount;
      //     totalPendingAmount += double.tryParse(milestone?.amount ?? '0') ?? 0.0;
      //   }
      //   else if (milestone?.status == "Partially Paid") {
      //     totalPendingAmount += double.tryParse(milestone?.outstandingAmt ?? '0') ?? 0.0;
      //   }
      // }

      for (int i = 0;
          i < apartmentDetailsResponse!.data!.milestones!.length;
          i++) {
        var milestone = apartmentDetailsResponse?.data?.milestones?[i];
        if (milestone?.status == "Pending") {
          lastPendingEventName = milestone?.eventName;
          lastPendingAmount = milestone?.amount;
          totalPendingAmount +=
              double.tryParse(milestone?.amount ?? '0') ?? 0.0;
          pendingStatus = true;
        } else if (milestone?.status == "Partially Paid") {
          totalPendingAmount +=
              double.tryParse(milestone?.outstandingAmt ?? '0') ?? 0.0;
        }
      }

      if (pendingStatus == false) {
        for (int i = 0;
            i < apartmentDetailsResponse!.data!.milestones!.length;
            i++) {
          var milestone = apartmentDetailsResponse?.data?.milestones?[i];
          if (milestone?.status == "Partially Paid") {
            lastPendingEventName = milestone?.eventName;
            lastPendingAmount = milestone?.amount;
          }
        }
      }
      isLoading = false;
      update();
    }
  }

  void getLedgerDetail() {
    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "apartment_id": Get.find<MainController>().apartmentId,
    };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "ledger_get"
    };

    log('params ---------->>>>>>>> $params');
    log('request==========>>>>>$request');

    int diff = 0;
    if (Get.find<AppHolder>().localDate != "") {
      var startTime = DateTime.parse(Get.find<AppHolder>().localDate ?? "");
      var currentTime = DateTime.now();
      diff = currentTime.difference(startTime).inHours;
    }
    if (diff >= 5 || Get.find<AppHolder>().localDate == "") {
      Get.log(request.toString());
      getLedgerDetailsUseCase.invoke(params, request).listen((event) {
        event.when(loading: () {
          isLoading = true;
          update();
        }, content: (response) async {
          int r = 0;
          ledgerDetailsResponse = response;
          Get.find<AppHolder>().ledgerDetail = jsonEncode(response).isNotEmpty ? jsonEncode(response) : "";
          r = ledgerDetailsResponse?.data?.milestones?.length ?? 0;
          if (r > 4) {
            l = 4;
          } else {
            l = r;
          }
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
    } else {
      isLoading = true;
      update();
      log("ledgerDetail===>>>${Get.find<AppHolder>().ledgerDetail!}");

      ledgerDetailsResponse = LedgerDetailsResponse.fromJson(
          jsonDecode(Get.find<AppHolder>().ledgerDetail!));
      isLoading = false;
      update();
    }
  }

  void getAllProject() {
    int diff = 0;

    if (Get.find<AppHolder>().localDate != "") {
      var startTime = DateTime.parse(Get.find<AppHolder>().localDate ?? "");
      var currentTime = DateTime.now();
      diff = currentTime.difference(startTime).inHours;
    }

    if (diff >= 5 || Get.find<AppHolder>().localDate == "") {
      allProjectUseCase.invoke().listen((event) {
        event.when(loading: () {
          isLoading = true;
          update();
        }, content: (response) async {
          allProjectResponse = response;
          Get.find<AppHolder>().projectData = jsonEncode(response).isNotEmpty ? jsonEncode(response) : "";
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
    } else {
      isLoading = true;
      update();

      allProjectResponse = AllProjectResponse.fromJson(
          jsonDecode(Get.find<AppHolder>().projectData!));
      isLoading = false;
      update();
    }
  }

  void receiptsGet(String ids, String milestoneId) {
    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "milestone_id": milestoneId,
      "receipt_id": ids,
      "apartment_id": Get.find<MainController>().apartmentId
    };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "receipt_pdf"
    };

    messageUseCase.invoke(params, request).listen((event) {
      event.when(
          loading: () {
            isLoading = true;
            update();
          },
          content: (response) async {},
          error: (error) {
            customSnackBar(error.toString());
          });
    })
      ..onDone(() async {
        isLoading = false;
        update();
      })
      ..addTo(subscribe);
  }

  void getReceipt(String rId, String milestoneId) {
    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "apartment_id": Get.find<MainController>().apartmentId,
      "receipt_id": rId,
      "milestone_id": milestoneId
    };
    Get.log(request.toString());
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "receipt_pdf",
    };
    log('ReceiptParams---------->>>>>>>> $params');
    log('ReceiptRequest==========>>>>>$request');
    Get.log(request.toString());
    messageUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        final appStorage = await getApplicationDocumentsDirectory();
        var targetPath =
            /*Platform.isIOS ? "/storage/emulated/0/Download/" :*/ appStorage
                .path;
        messageData = response;
        String htmlContent = response?.data?["html"];
        var targetFileName = "statement_marathon.pdf";
        log('htmlContent==========>>>>>$htmlContent');
        log('targetPath==========>>>>>$targetPath');
        final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
            htmlContent: htmlContent,
            configuration: PdfConfiguration(
              targetDirectory: targetPath,
              targetName: targetFileName,
              printSize: PrintSize.A4,
              printOrientation: PrintOrientation.Landscape,
            ));
        isLoading = false;
        Get.log("${generatedPdfFile}mana file");
        if (generatedPdfFile.existsSync()) {
          customSnackBar('File downloaded');
          OpenFile.open(generatedPdfFile.path);
        } else {
          customSnackBar("Try again");
        }
        update();
      }, error: (error) {
        customSnackBar(error.toString());
      });
    })
      ..onDone(() async {
        update();
      })
      ..addTo(subscribe);
  }
}
