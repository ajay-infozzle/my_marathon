import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_to_pdf_plus/html_to_pdf_plus.dart';
import 'package:html_to_pdf_plus/pdf_configuration.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/controllers/mainController/main_controller.dart';
import 'package:marathon/data/services/analytics_service.dart';
import 'package:marathon/domain/use_cases/message_/message_use_case.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/server/api/api_const.dart';
import '../../../../../data/storage/app/app_holder.dart';
import '../../../../../data/tools/toast/custom_snackbar.dart';
import '../../../../../domain/entities/ledge/payment/payment_response.dart';
import '../../../../../domain/entities/message/message.dart';
import '../../../../../domain/use_cases/ledger_use_case/payment/payment_info_use_case.dart';

class MakePaymentController extends BaseController {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController transationController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  PaymentInfoUseCase paymentInfoUseCase;
  MessageUseCase messageUseCase;
  PaymentResponse? paymentResponse;
  MainController mainController = MainController();
  MessageData? messageData;
  MakePaymentController(this.paymentInfoUseCase, this.messageUseCase);

  bool isLoading = false;




  @override
  void onInit() {
    // Get.log("${Get.arguments['receipt_ids']} mana ids");
    getPaymentInfo(
        Get.arguments['due_amount'], Get.arguments["milestone_id"]);

    super.onInit();
  }



  void getPaymentInfo(String amount, String id) {
    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "apartment_id": Get.find<MainController>().apartmentId,
      "milestone_id": id,
      "due_amount": amount,
    };
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "payment_get",
    };
    Get.log(request.toString());
    paymentInfoUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        paymentResponse = response;
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

  void makePayment() {
    if (bankNameController.text.isEmpty) {
      customSnackBar("Please enter bank name");
      return;
    }
    if (amountController.text.isEmpty) {
      customSnackBar("Please enter amount");
      return;
    }
    if (transationController.text.isEmpty) {
      customSnackBar("Please enter transaction number");
      return;
    }

    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "apartment_id": Get.find<MainController>().apartmentId,
      "bank_name": bankNameController.text,
      "amount": amountController.text,
      "remarks": remarkController.text,
      "transaction_no": transationController.text,
    };
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "payment_post",
    };
    Get.log(request.toString());
    AnalyticsService.instance.onPayment();

    messageUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.status == "success") {
          customSnackBar(response?.status);
        } else {
          customSnackBar("try again");
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
  }

  void getReceipt(String rId) {
    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "apartment_id": Get.find<MainController>().apartmentId,
      "receipt_id": rId,
      "milestone_id": Get.arguments["milestone_id"]
    };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "receipt_pdf",
    };

    log('request==========>>>>>$request');
    Get.log(request.toString());
    messageUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        final appStorage = await getApplicationDocumentsDirectory();
        var targetPath = Platform.isAndroid
            ? "/storage/emulated/0/Download/"
            : appStorage.path;
        messageData = response;
        log('response==========>>>>>${response}');
        String htmlContent = response?.data?["html"];
        var targetFileName = "receipt_${Get.arguments["milestone_id"]}.pdf";
        final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
            htmlContent: htmlContent,
            configuration: PdfConfiguration(
              targetDirectory:  targetPath,
              targetName: targetFileName,
              printSize: PrintSize.A4,
              printOrientation: PrintOrientation.Landscape,
            ));

        Get.log("${generatedPdfFile}mana file");
        if (generatedPdfFile.existsSync()) {
          customSnackBar('File downloaded');
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
        update();
      })
      ..addTo(subscribe);
  }
}
