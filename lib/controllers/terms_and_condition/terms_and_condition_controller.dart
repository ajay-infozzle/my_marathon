import 'dart:developer';
import 'package:marathon/domain/entities/terms_and_condition/terms_and_condition_response.dart';
import 'package:marathon/domain/use_cases/terms_and_condition_use_case/terms_and_condition_use_case.dart';
import 'package:rxdart/rxdart.dart';
import '../../data/tools/toast/custom_snackbar.dart';
import '../base/base_controller.dart';

class TermsAndConditionController extends BaseController {
  TermsAndConditionUseCase termsAndConditionUseCase;
  TermsAndConditionResponse? termsAndConditionResponse;
  bool isLoading = false;
  TermsAndConditionController(this.termsAndConditionUseCase);

  @override
  void onInit() {
    getTermsAndConditionData();
    super.onInit();
  }

  void getTermsAndConditionData() {
    // int diff = 0;
    // if (Get.find<AppHolder>().localDate != "") {
    //   var startTime = DateTime.parse(Get.find<AppHolder>().localDate ?? "");
    //   var currentTime = DateTime.now();
    //   diff = currentTime.difference(startTime).inHours;
    // }
    termsAndConditionUseCase.invoke().listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        termsAndConditionResponse = response;
        log('response==========>>>>>$response');
        log('termsAndConditionResponse==========>>>>>${termsAndConditionResponse?.content}');
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
