import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/controllers/mainController/main_controller.dart';
import 'package:marathon/data/services/analytics_service.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/domain/entities/message/message.dart';
import 'package:marathon/domain/entities/support/faq_data_response.dart';
import 'package:marathon/domain/use_cases/message_/send_message_use_case.dart';
import 'package:marathon/domain/use_cases/support_use_case/get_faqdata_use_case.dart';
import 'package:rxdart/rxdart.dart';
import '../../data/server/api/api_const.dart';
import '../../data/tools/toast/custom_snackbar.dart';
import '../../domain/entities/support/faq_data.dart';

class SupportController extends BaseController {
  SendMessageUseCase messageUseCase;
  MessageData? messageData;
  bool isLoading = false;
  TextEditingController subjectController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  GetFaqDataUseCase getFaqDataUseCase;
  FaqDataResponse? faqDataResponse;
  List<FaqData> searchFaq = [];
  List<FaqData> faqData = [];
  List<String> faqCategory = [];
  String? selectCategory = "";
  List openIndex = [];

  void openTab(index) {
    if (openIndex.contains(index)) {
      openIndex.remove(index);
    } else {
      openIndex.add(index);
    }
    update();
  }

  bool isSearch = false;
  setIsSearch(bool value) {
    isSearch = value;
    update();
  }

  SupportController(
    this.messageUseCase,
    this.getFaqDataUseCase,
  );

  TextEditingController documentName = TextEditingController();
  String bookName = "";

  List<String> list = [];
  File? file;
  bool attached = false;

  void takeBook() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'jpg', 'pdf', 'png', 'svg'],
    );
    file = File(result?.paths.first ?? "");
    int fileSize = file!.lengthSync();
    print("FileSize===>>>>$fileSize");
    if (fileSize > 8 * 1024 * 1024) {
      customSnackBar("File size should not exceed 8 MB");
      return;
    }
    bookName = result!.names.first!;
    documentName.text = bookName;
    if (file != null) {
      attached = true;
    }
    print(bookName);
    update();
  }

  @override
  void onInit() {
    getFaqData();
    super.onInit();
  }

  void sentMessage() {
    if (subjectController.text.isEmpty) {
      customSnackBar("Please enter Subject");
      return;
    }
    if (messageController.text.isEmpty) {
      customSnackBar("Please enter Message");
      return;
    }
    if (attached == false) {
      customSnackBar("Please attach file");
      return;
    }
    String email = Get.find<AppHolder>().email ?? Get.find<AppHolder>().number;
    Map<String, dynamic> request = Get.find<AppHolder>().custId != 0
        ?
          {
            "message": messageController.text,
            "subject": subjectController.text,
            "email": email,
            "cust_id": Get.find<AppHolder>().custId,
            "apartment_id": Get.find<MainController>().apartmentId,
            "document_file": file
          }
        : {
            "message": messageController.text,
            "subject": subjectController.text,
            "email": email,
            "document_file": file
          };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "contact_post"
    };

    AnalyticsService.instance.onContactFormSubmission();
    log('file==========>>>>>$file');
    log('requestFile==========>>>>>$request');

    messageUseCase.invoke(
      params,
      file!,
      Get.find<AppHolder>().email,
      messageController.text.toString(),
      subjectController.text,
    )
        .listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        if (response?.status == "success") {
          customSnackBar(response?.data?['message'].toString());
          log('response==========>>>>>$response');
          messageController.text = '';
          subjectController.text = '';
          emailController.text = '';
        } else {
          customSnackBar(response?.message.toString());
        }
        update();
      }, error: (error) {
        customSnackBar("please try again".toString());
      });
    })
      ..onDone(() async {
        messageController.text = '';
        subjectController.text = '';
        emailController.text = '';
        isLoading = false;
        update();
      })
      ..addTo(subscribe);
  }

  void getFaqData() {
    Map<String, dynamic> params = {"apikey": Api.apiKey, "action": "faq"};
    log('params ---------->>>>>>>> $params');
    int diff = 0;
    if (Get.find<AppHolder>().localDate != "") {
      var startTime = DateTime.parse(Get.find<AppHolder>().localDate ?? "");
      var currentTime = DateTime.now();
      diff = currentTime.difference(startTime).inHours;
    }
    // if (diff >= 5 || Get.find<AppHolder>().localDate == "") {
    getFaqDataUseCase.invoke(params).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        faqDataResponse = response;
        faqDataResponse!.data!.forEach((element) {
          if (!faqCategory.contains(element.category)) {
            faqCategory.add(element.category.toString());
          }
        });

        log('faqCategory==========>>>>>$faqCategory');

        //  Get.find<AppHolder>().faqData = jsonEncode(response) ?? "";
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
    //}
    // else {
    //   isLoading = true;
    //   update();
    //   log('faqData=====>>>>>${Get.find<AppHolder>().faqData!}');
    //   faq = FaqResponse.fromJson(jsonDecode(Get.find<AppHolder>().faqData!));
    //   isLoading = false;
    //   update();
    // }
  }

  questionList(String name) {
    faqData.clear();
    for (var element in faqDataResponse!.data!) {
      if (element.category!.contains(name)) {
        faqData.add(element);
      }
    }
    update();
    log('faqData==========>>>>>${faqData.length}');
  }
}
