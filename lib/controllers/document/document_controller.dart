import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_to_pdf_plus/html_to_pdf_plus.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/controllers/mainController/main_controller.dart';
import 'package:marathon/data/services/analytics_service.dart';
import 'package:marathon/domain/entities/document_post/post_document_response.dart';
import 'package:marathon/domain/entities/documents/documents_response.dart';
import 'package:marathon/domain/entities/message/message.dart';
import 'package:marathon/domain/use_cases/get_documents/get_documents_use_case.dart';
import 'package:marathon/domain/use_cases/get_documents/post_documents_use_case.dart';
import 'package:marathon/domain/use_cases/message_/message_use_case.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/server/api/api_const.dart';
import '../../data/storage/app/app_holder.dart';
import '../../data/tools/toast/custom_snackbar.dart';
import '../../domain/entities/aparments/apartment_details/apartment_details_response.dart';

class DocumentController extends BaseController {

  TextEditingController documentName = TextEditingController();
  TextEditingController uploadDocument = TextEditingController();

  String bookName = "";
  DocumentsResponse? responses;
  GetDocumentsUseCase getDocumentsUseCase;
  PostDocumentsUseCase postDocumentsUseCase;
  PostDocumentResponse? postDocumentResponse;
  MessageUseCase messageUseCase;
  MessageData? messageData;
  bool isLoading = false;
  List<String> list = [];
  File? file;
  List openIndex = [];
  void openTab(index) {
    if (openIndex.contains(index)) {
      openIndex.remove(index);
    } else {
      openIndex.add(index);
    }
    update();
  }

  DocumentController(this.getDocumentsUseCase, this.postDocumentsUseCase, this.messageUseCase);

  void takeBook() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    file = File(result?.paths.first ?? "");
    int fileSize = file!.lengthSync();
    print("FileSize===>>>>$fileSize");
    if (fileSize > 8 * 1024 * 1024) {
      customSnackBar("File size should not exceed 8 MB");
      return;
    }

    bookName = result!.names.first!;
    uploadDocument.text = bookName;
    print(bookName);
    update();
  }

  void getApartmentDetail(String id) {
    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "apartment_id": id
    };
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "documents_get"
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
      getDocumentsUseCase.invoke(params, request).listen((event) {
        event.when(loading: () {
          isLoading = true;
          update();
        }, content: (response) async {
          responses = response;
          responses?.data?.receipts?.forEach((k, v) {
            list.add(k.toString());
          });
          Get.find<AppHolder>().documentData = jsonEncode(response) ?? "";
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
      log('documentData====>>>>${Get.find<AppHolder>().documentData!}');
      responses = DocumentsResponse.fromJson(
          jsonDecode(Get.find<AppHolder>().documentData!));
      isLoading = false;
      update();
    }
  }

  void postFile() {
    if (documentName.text.isEmpty) {
      customSnackBar("please write document name");
      return;
    }
    if (bookName.isEmpty) {
      customSnackBar("please write document type");
      return;
    }
    if (file == null) {
      customSnackBar("please choose document");
      return;
    }

    Map<String, dynamic> request = {
      "cust_id": Get.find<AppHolder>().custId,
      "apartment_id": Get.find<MainController>().apartmentId,
      "document_type": uploadDocument.text,
      "document_name": documentName.text,
      "document_file": file
    };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "document_post"
    };

    AnalyticsService.instance.onDocumentUpload();
    // File documentFile,String? apartmentId,String? documentType, String? custId
    log('request==========>>>>>$request');
    log('params==========>>>>>$params');
    Get.log(request.toString());
    postDocumentsUseCase.invoke(
      params,
      file!,
      Get.find<MainController>().apartmentId,
      uploadDocument.text,
      documentName.text,
      Get.find<AppHolder>().custId.toString() ?? "",
    )
        .listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        postDocumentResponse = response;
        log('response ---------->>>>>>>> $response');
        customSnackBar("Uploaded");
        update();
      }, error: (error) {
        customSnackBar(error.toString());
        log('error==========>>>>>$error');
      });
    })
      ..onDone(() async {
        isLoading = false;
        update();
      })
      ..addTo(subscribe);
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
        update();
      }, content: (response) async {
        final appStorage = await getApplicationDocumentsDirectory();
        // var targetPath = Platform.isIOS ? "/storage/emulated/0/Download/" : appStorage.path;
        log('targetPath==========>>>>>${appStorage.path}');
        messageData = response;
        String htmlContent = response?.data?["html"];
        var targetFileName = "statement_marathon.pdf";
        final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
            htmlContent: htmlContent,
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
        update();
      })
      ..addTo(subscribe);
  }
}
