import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:html_to_pdf_plus/html_to_pdf_plus.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/controllers/mainController/main_controller.dart';
import 'package:marathon/domain/entities/ledge/ledger_details_response.dart';
import 'package:marathon/domain/entities/message/message.dart';
import 'package:marathon/domain/use_cases/ledger_use_case/get_ledger_details_use_case.dart';
import 'package:marathon/domain/use_cases/message_/message_use_case.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data/server/api/api_const.dart';
import '../../../data/storage/app/app_holder.dart';
import '../../../data/tools/toast/custom_snackbar.dart';

class PaymentsController extends BaseController {
  GetLedgerDetailsUseCase getLedgerDetailsUseCase;
  LedgerDetailsResponse? ledgerDetailsResponse;
  MessageUseCase messageUseCase;
  MessageData? messageData;
  bool loadMore = true;
  bool isLoading = false;
  String loadingText = "";
  int l = 0;

  List openIndex = [];
  void openTab(index) {
    if (openIndex.contains(index)) {
      openIndex.remove(index);
    } else {
      openIndex.add(index);
    }
    update();
  }

  void tabToMore() {
    loadMore = false;
    l = ledgerDetailsResponse?.data?.milestones?.length ?? 0;
    update();
  }

  @override
  void onInit() {
    getApartmentDetail();
    super.onInit();
  }

  PaymentsController(this.getLedgerDetailsUseCase, this.messageUseCase);

  void getApartmentDetail() {
    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "apartment_id": Get.find<MainController>().apartmentId,
    };
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "ledger_get"
    };
    log('params ---------->>>>>>>> $params');
    log('request ---------->>>>>>>> ${Get.find<AppHolder>().localDate}');
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
          Get.find<AppHolder>().ledgerData = jsonEncode(response).isNotEmpty ?jsonEncode(response) : "";
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
      log('ledgerData=====>>>>>${Get.find<AppHolder>().ledgerData!}');
      ledgerDetailsResponse = LedgerDetailsResponse.fromJson(
          jsonDecode(Get.find<AppHolder>().ledgerData!));
      isLoading = false;
      update();
    }
  }

  void getDocuments() {
    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "apartment_id": Get.find<MainController>().apartmentId,
    };
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "statement_pdf"
    };
    Get.log(request.toString());
    messageUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        loadingText = "Please wait download in progress...";
        update();
      }, content: (response) async {
        final appStorage = await getApplicationDocumentsDirectory();
        //var targetPath = Platform.isIOS ? "/storage/emulated/0/Download/" : appStorage.path;
        log('targetPath==========>>>>>${appStorage.path}', name: "statement_pdf on payments_controller");
        messageData = response;
        String? htmlContent = response?.data?["html"];
        var targetFileName = "statement_marathon.pdf";
        final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
            htmlContent: htmlContent ?? "",
            configuration: PdfConfiguration(
              targetDirectory: appStorage.path,
              targetName: targetFileName,
              printSize: PrintSize.A4,
              printOrientation: PrintOrientation.Landscape,
            ));
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
        isLoading = false;
        loadingText = "";
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
        var targetPath = appStorage.path;
        messageData = response;
        log('response--------->>>>>>>>$response');
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
        update();
        Get.log("${generatedPdfFile}mana file");
        if (generatedPdfFile.existsSync()) {
          isLoading = false;
          update();
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
