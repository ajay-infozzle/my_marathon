import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/controllers/mainController/main_controller.dart';
import 'package:marathon/data/services/analytics_service.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/domain/entities/message/message.dart';
import 'package:marathon/domain/entities/support/faq_data_response.dart';
import 'package:marathon/domain/use_cases/message_/send_message_use_case.dart';
import 'package:marathon/domain/use_cases/support_use_case/get_faqdata_use_case.dart';
import 'package:phone_form_field/phone_form_field.dart';
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

  TextEditingController complainSubjectController = TextEditingController();
  TextEditingController complainMessageController = TextEditingController();

  TextEditingController emailChangeController = TextEditingController();
  PhoneController mobileChangeController = PhoneController(initialValue: const PhoneNumber(isoCode: IsoCode.IN, nsn: ''));
  
  // TextEditingController otpController = TextEditingController();
  String otp = '';

  TextEditingController visitDateCont = TextEditingController();
  TextEditingController visitTimeCont = TextEditingController();
  TextEditingController visitPurposeCont = TextEditingController();

  TextEditingController nameChangeCont = TextEditingController();

  bool showOtpField = false;
  String? selectService = "";
  List<String> services = [
    "General Service Request",
    "Complaint",
    "Flat Visit Request",
    "Name Change/Deletion/Updation Request",
    "Email ID Change Request",
    "Mobile Number Change Request"
  ];

  GetFaqDataUseCase getFaqDataUseCase;
  FaqDataResponse? faqDataResponse;
  List<FaqData> searchFaq = [];
  List<FaqData> faqData = [];
  List<String> faqCategory = [];
  String? selectCategory = "";
  List openIndex = [];

  void openTab(index) {
    file = null ;
    switch (index) {
      case 1:
        attached = false ;
        break;
      case 2:
        complainAttached = false ;
        break;
      default:
    }
    
    // if (openIndex.contains(index)) {
    //   openIndex.remove(index);
    // } else {
    //   openIndex.add(index);
    // }

    openIndex.clear();
    openIndex.add(index);

    showOtpField = false;
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

  // TextEditingController documentName = TextEditingController();
  String bookName = "";

  // List<String> list = [];
  File? file;
  bool attached = false;

  String complainName = "";
  bool complainAttached = false;
  bool nameChaneFormAttached = false;

  void takeBook() async {
    final filePickerResult = await filePicker();
    if(filePickerResult == null){
      return ;
    }

    bookName = filePickerResult.names.first!;
    // documentName.text = bookName;
    if (file != null) {
      attached = true;
    }
    if (kDebugMode) {
      print(bookName);
    }
    update();
  }

  void takeComplainAttachment() async {
    final filePickerResult = await filePicker();
    if(filePickerResult == null){
      return ;
    }

    complainName = filePickerResult.names.first!;
    if (file != null) {
      complainAttached = true;
    }
    if (kDebugMode) {
      print(complainName);
    }
    update();
  }

  void takeNameChangeFormAttachment() async {
    final filePickerResult = await filePicker();
    if(filePickerResult == null){
      return ;
    }

    nameChangeCont.text = filePickerResult.names.first!;
    if (file != null) {
      nameChaneFormAttached = true;
    }
    if (kDebugMode) {
      print(nameChangeCont.text);
    }
    update();
  }

  Future<FilePickerResult?> filePicker() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'jpg', 'png', 'svg', 'docx'],
    );
    file = File(result?.paths.first ?? "");
    int fileSize = file!.lengthSync();
    if (kDebugMode) {
      print("FileSize===>>>>$fileSize");
    }
    if (fileSize > 8 * 1024 * 1024) {
      customSnackBar("File size should not exceed 8 MB");
      return null;
    }

    return result;
  }

  @override
  void onInit() {
    getFaqData();
    selectService = services[0];
    openTab(1);
    super.onInit();
  }


  void getDateFromUser(BuildContext context) async{
    DateTime? pickedDate = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime(2050)
    );

    if(pickedDate != null){
      visitDateCont.text = DateFormat.yMd().format(pickedDate);
    }
  }

  
  void getTimeFromUser(BuildContext context) async{
    var timePicker = await showTimePicker(
      context: context, 
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    );

    late String formattedTime ;
    if(timePicker!=null){
      // ignore: use_build_context_synchronously
      formattedTime = timePicker.format(context);
      visitTimeCont.text = formattedTime;
    }
  }

  void sentMessage() async{
    if (subjectController.text.isEmpty) {
      customSnackBar("Please enter Subject");
      return;
    }
    if (messageController.text.isEmpty) {
      customSnackBar("Please enter Message");
      return;
    }
    // if (attached == false) {
    //   customSnackBar("Please attach file");
    //   return;
    // }
    String email = Get.find<AppHolder>().email.isNotEmpty ? Get.find<AppHolder>().email : Get.find<AppHolder>().number;
    Map<String, dynamic> request = Get.find<AppHolder>().custId != 0
        ?
          {
            "message": messageController.text,
            "subject": subjectController.text,
            "email": email,
            "cust_id": Get.find<AppHolder>().custId,
            "apartment_id": Get.find<MainController>().apartmentId,
            // "document_file": file
            "document_file": file == null ? "" : await MultipartFile.fromFile(file!.path, filename: 'general_form')
          }
        : {
            "message": messageController.text,
            "subject": subjectController.text,
            "email": email,
            // "document_file": file
            "document_file": file == null ? "" : await MultipartFile.fromFile(file!.path, filename: 'general_form')
          };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "contact_post"
    };

    AnalyticsService.instance.onContactFormSubmission();
    log('file==========>>>>>$file');
    log('sent message request==========>>>>>$request');


    try {
      isLoading = true;
      update();

      Dio dio = Dio();
      var response = await dio.post(
        Api.messageFormApi,
        data: FormData.fromMap(request), //~ FormData for file uploads
        queryParameters: params
      );
      log("('sent message form response=======>>>: ${response.data}'");
      
      if(response.statusCode == 200){
        customSnackBar(response.data?['data']['message'].toString() ?? 'Form submitted successfully');
        messageController.text = '';
        subjectController.text = '';
        emailController.text = '';
        file = null;
      }else {
        customSnackBar(response.data?['data']['message'].toString() ?? 'Submission failed');
      }
    } 
    on DioException catch (e) {
      log('Failed to upload message form =======>>>: $e');
      customSnackBar("Failed to upload message form. Please try again.");
    } catch (e) {
      log('Unexpected error to upload message form: $e');
      customSnackBar("Please try again.");
    } finally {
      isLoading = false;
      update();
    }

    // messageUseCase.invoke(
    //   params,
    //   file,
    //   Get.find<AppHolder>().email,
    //   messageController.text.toString(),
    //   subjectController.text,
    // )
    //     .listen((event) {
    //   event.when(loading: () {
    //     isLoading = true;
    //     update();
    //   }, content: (response) async {
    //     if (response?.status == "success") {
    //       customSnackBar(response?.data?['message'].toString());
    //       log('response==========>>>>>$response');
    //       messageController.text = '';
    //       subjectController.text = '';
    //       emailController.text = '';
    //       file = null;
    //     } else {
    //       customSnackBar(response?.message.toString());
    //     }
    //     update();
    //   }, error: (error) {
    //     customSnackBar("please try again".toString());
    //   });
    // })
    //   ..onDone(() async {
    //     messageController.text = '';
    //     subjectController.text = '';
    //     emailController.text = '';
    //     file = null;
    //     isLoading = false;
    //     update();
    //   })
    //   ..addTo(subscribe);
  }

  void sendComplainForm() async{
    if (complainSubjectController.text.isEmpty) {
      customSnackBar("Please enter Subject");
      return;
    }
    if (complainMessageController.text.isEmpty) {
      customSnackBar("Please enter Message");
      return;
    }
    // if (complainAttached == false || file == null) {
    //   customSnackBar("Please attach a valid file");
    //   return;
    // }
    String email = Get.find<AppHolder>().email.isNotEmpty ? Get.find<AppHolder>().email : Get.find<AppHolder>().number;
    Map<String, dynamic> request = Get.find<AppHolder>().custId != 0
        ?
          {
            "message": complainMessageController.text,
            "subject": complainSubjectController.text,
            "email": email,
            "cust_id": Get.find<AppHolder>().custId,
            "apartment_id": Get.find<MainController>().apartmentId,
            "document_file":  file == null ? "" : await MultipartFile.fromFile(file!.path, filename: 'complaint_form')
          }
        : {
            "message": complainMessageController.text,
            "subject": complainSubjectController.text,
            "email": email,
            "document_file":  file == null ? "" : await MultipartFile.fromFile(file!.path, filename: 'complaint_form')
          };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "complaint_post" 
    };

    AnalyticsService.instance.onContactFormSubmission();
    log('file==========>>>>>$file');
    log('complain request==========>>>>>$request');


    try {
      isLoading = true;
      update();

      Dio dio = Dio();
      var response = await dio.post(
        Api.complainFormApi,
        data: FormData.fromMap(request), //~ FormData for file uploads
        queryParameters: params
      );
      log("('complain form response=======>>>: ${response.data}'");
      
      if(response.statusCode == 200){
        customSnackBar(response.data?['data']['message'].toString() ?? 'Form submitted successfully');
        complainMessageController.clear();
        complainSubjectController.clear();
        complainAttached = false;
        file = null;
      }else {
        customSnackBar(response.data?['data']['message'].toString() ?? 'Submission failed');
      }
    } 
    on DioException catch (e) {
      log('Failed to upload complaint form =======>>>: $e');
      customSnackBar("Failed to upload complaint form. Please try again.");
    } catch (e) {
      log('Unexpected error to upload complaint form: $e');
      customSnackBar("Please try again.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void sendFlatVisitRequestForm() async{
    if (visitDateCont.text.isEmpty) {
      customSnackBar("Please choose visit date");
      return;
    }
    if (visitTimeCont.text.isEmpty) {
      customSnackBar("Please choose visit time");
      return;
    }
    if (visitPurposeCont.text.isEmpty) {
      customSnackBar("Please enter purpose of visit");
      return;
    }
    String email = Get.find<AppHolder>().email.isNotEmpty ? Get.find<AppHolder>().email : Get.find<AppHolder>().number;
    Map<String, dynamic> request = Get.find<AppHolder>().custId != 0
        ?
          {
            "date": visitDateCont.text,
            "time": visitTimeCont.text,
            "message": visitPurposeCont.text,
            "email": email,
            "cust_id": Get.find<AppHolder>().custId,
            "apartment_id": Get.find<MainController>().apartmentId,
          }
        : {
            "date": visitDateCont.text,
            "time": visitTimeCont.text,
            "message": visitPurposeCont.text,
            "email": email,
          };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "flat_visit_post"
    };

    AnalyticsService.instance.onContactFormSubmission();
    log('file==========>>>>>$file');
    log('flat visit form request==========>>>>>$request');


    try {
      isLoading = true;
      update();

      Dio dio = Dio();
      var response = await dio.post(
        Api.flatVisitFormApi,
        data: FormData.fromMap(request),
        queryParameters: params
      );
      log("('flat visit form response=======>>>: ${response.data}'");
      
      if(response.statusCode == 200){
        customSnackBar(response.data?['data']['message'].toString() ?? 'Form submitted successfully');
        visitDateCont.clear();
        visitTimeCont.clear();
        visitPurposeCont.clear();
      }else {
        customSnackBar(response.data?['data']['message'].toString() ?? 'Submission failed');
      }
    } 
    on DioException catch (e) {
      log('Failed to upload flat visit form =======>>>: $e');
      customSnackBar("Failed to upload flat visit form. Please try again.");
    } catch (e) {
      log('Unexpected error to upload flat visit form: $e');
      customSnackBar("Please try again.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void sendNameChangeForm() async{
    if (nameChaneFormAttached == false || file == null) {
      customSnackBar("Please attach a valid file");
      return;
    }
    String email = Get.find<AppHolder>().email.isNotEmpty ? Get.find<AppHolder>().email : Get.find<AppHolder>().number;
    Map<String, dynamic> request = Get.find<AppHolder>().custId != 0
        ?
          {
            "email": email,
            "cust_id": Get.find<AppHolder>().custId,
            "apartment_id": Get.find<MainController>().apartmentId,
            "document_file": await MultipartFile.fromFile(file!.path, filename: 'name_change_form')
          }
        : {
            "email": email,
            "document_file": await MultipartFile.fromFile(file!.path, filename: 'name_change_form')
          };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "name_change_post" //~ to change
    };

    AnalyticsService.instance.onContactFormSubmission();
    log('file==========>>>>>$file');
    log('send name change form request==========>>>>>$request');


    try {
      isLoading = true;
      update();

      Dio dio = Dio();
      var response = await dio.post(
        Api.nameChangeFormApi,
        data: FormData.fromMap(request), 
        queryParameters: params
      );
      log("('name change request form response=======>>>: ${response.data}'");
      
      if(response.statusCode == 200){
        customSnackBar(response.data?['data']['message'].toString() ?? 'Form submitted successfully');
        nameChangeCont.clear();
        nameChaneFormAttached = false;
        file = null;
      }else {
        customSnackBar(response.data?['data']['message'].toString() ?? 'Submission failed');
      }
    } 
    on DioException catch (e) {
      log('Failed to upload name change request form =======>>>: $e');
      customSnackBar("Failed to upload name change request form. Please try again.");
    } catch (e) {
      log('Unexpected error to upload complaint form: $e');
      customSnackBar("Please try again.");
    } finally {
      isLoading = false;
      update();
    }
  }
  
  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

  void sendOtp({bool isEmail = false, bool isMobile = false}) async{
    if (isEmail && emailChangeController.text.isEmpty) {
      customSnackBar("Please enter new email");
      return;
    }

    if (isEmail && !isValidEmail(emailChangeController.text.trim())) {
      customSnackBar("Please enter a valid email address!");
      return;
    }

    if (isMobile && mobileChangeController.value.nsn.isEmpty) {
      customSnackBar("Please enter new mobile number !");
      return;
    }
    
    String custID = Get.find<AppHolder>().custId.toString() ;
    Map<String, dynamic> request = 
    isEmail ?
    {
      "email": emailChangeController.text.trim(),
      "cust_id": custID
    }
    :
    {
      "mobile": mobileChangeController.value.nsn.trim(),
      "cust_id": custID
    };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "verification_otp_get" 
    };

    AnalyticsService.instance.onContactFormSubmission();
    log('send otp request==========>>>>>$request');


    try {
      isLoading = true;
      update();

      Dio dio = Dio();
      var response = await dio.post(
        isEmail ? Api.emailChangeFormApi : Api.mobileChangeFormApi,
        data: FormData.fromMap(request),
        queryParameters: params
      );
      log("('send otp response=======>>>: ${response.data}'");
      
      if(response.statusCode == 200){
        if(response.data?['status'] == "success"){
          customSnackBar('OTP sent successfully') ;
        }

        if(response.data?['status'] == "error"){
          customSnackBar(response.data?['message'] ?? "Something went wrong !") ;
        }
      }else {
        if(response.data?['status'] == "error"){
          customSnackBar(response.data?['message'] ?? "Something went wrong !") ;
        }
      }

      isLoading = false;
      showOtpField = true;
      update();
    } 
    on DioException catch (e) {
      log('Failed email/mobile change form =======>>>: $e');
      customSnackBar("Failed, Please try again.");
    } catch (e) {
      log('Unexpected error to email/mobile chnage request form: $e');
      customSnackBar("Please try again.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void verifyOtp({bool isEmail = false, bool isMobile = false}) async{
    log("current entered otp --> $otp");
    log("emailChangeController --> ${emailChangeController.text}");
    log("mobileChangeController --> ${mobileChangeController.value.countryCode}${mobileChangeController.value.nsn}");
    
    String custID = Get.find<AppHolder>().custId.toString() ;
    Map<String, dynamic> request = 
    isEmail ?
    {
      "cust_id": custID,
      "otp":  otp.trim()
    }
    :
    {
      "cust_id": custID,
      "otp": otp.trim()
    };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "verification_otp_post" 
    };

    AnalyticsService.instance.onContactFormSubmission();
    log('verify otp request==========>>>>>$request');


    try {
      isLoading = true;
      update();

      Dio dio = Dio();
      var response = await dio.post(
        Api.verifyOtpApi,
        data: FormData.fromMap(request),
        queryParameters: params
      );
      log("('otp verification form response=======>>>: ${response.data}'");
      
      if(response.statusCode == 200){
        if(response.data?['status'] == "success"){
          // customSnackBar('OTP Verified') ;
          postOtpverification(
            custId: custID,
            isEmail: isEmail,
            isMobile: isMobile,
            email: emailChangeController.text,
            mobile: mobileChangeController.value.countryCode+mobileChangeController.value.nsn
          );
        }

        if(response.data?['status'] == "error"){
          customSnackBar(response.data?['message'] ?? "Something went wrong !") ;
          isLoading = false;
          update();
        }
      }else {
        if(response.data?['status'] == "error"){
          customSnackBar(response.data?['message'] ?? "Something went wrong , try again !") ;
          isLoading = false;
          update();
        }
      }

      // isLoading = false;
      // showOtpField = false;
      // emailChangeController.clear();
      // mobileChangeController.value = const PhoneNumber(isoCode: IsoCode.IN, nsn: '');
      // otpController.clear();
      // update();
    } 
    on DioException catch (e) {
      log('Failed otp verification =======>>>: $e');
      customSnackBar("Failed, Please try again.");
    } catch (e) {
      log('Unexpected error to verify otp : $e');
      customSnackBar("Please try again.");
    } finally {
      // isLoading = false;
      // update();
    }
  }

  void postOtpverification({bool isEmail = false, bool isMobile = false, String email = '', String mobile = '', required String custId}) async{
  
    Map<String, dynamic> request = 
    isMobile ?
    {
      "new_mobile": mobile,
      "apartment_id": Get.find<MainController>().apartmentId,
      "cust_id" : custId
    }
    :
    {
      "new_email": email,
      "apartment_id": Get.find<MainController>().apartmentId,
      "cust_id" : custId
    };

    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": isEmail ? "email_change_post" : "mobile_change_post" 
    };

    AnalyticsService.instance.onContactFormSubmission();
    log('post otp verification request==========>>>>>$request');


    try {
      Dio dio = Dio();
      var response = await dio.post(
        Api.verifyOtpApi,
        data: FormData.fromMap(request),
        queryParameters: params
      );
      log("('contact change api response=======>>>: ${response.data}'");
      
      if(response.statusCode == 200){
        if(response.data?['status'] == "success"){
          customSnackBar(isEmail ? (response.data?['data']['message'] ?? "Email Changed Successfuly") : (response.data?['data']['message'] ?? "Mobile Number Changed Successfuly") ) ;
        }
        

        if(response.data?['status'] == "error"){
          customSnackBar(response.data?['message'] ?? "Something went wrong !") ;
        }
      }else {
        if(response.data?['status'] == "error"){
          customSnackBar(response.data?['message'] ?? "Something went wrong !") ;
        }
      }

      isLoading = false;
      showOtpField = false;
      emailChangeController.clear();
      mobileChangeController.value = const PhoneNumber(isoCode: IsoCode.IN, nsn: '');
      // otpController.clear();
      update();
    } 
    on DioException catch (e) {
      log('Failed to change contact =======>>>: $e');
      customSnackBar("Failed, Please try again.");
    } catch (e) {
      log('Unexpected error to change contact : $e');
      customSnackBar("Please try again.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void getFaqData() {
    Map<String, dynamic> params = {"apikey": Api.apiKey, "action": "faq"};
    log('params ---------->>>>>>>> $params');
    // int diff = 0;
    // if (Get.find<AppHolder>().localDate != "") {
    //   var startTime = DateTime.parse(Get.find<AppHolder>().localDate ?? "");
    //   var currentTime = DateTime.now();
    //   diff = currentTime.difference(startTime).inHours;
    // }
    // if (diff >= 5 || Get.find<AppHolder>().localDate == "") {
    getFaqDataUseCase.invoke(params).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        faqDataResponse = response;
        // ignore: avoid_function_literals_in_foreach_calls
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
