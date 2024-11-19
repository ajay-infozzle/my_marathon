import 'dart:developer';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import 'package:marathon/controllers/home/apartment_details_controller/apartment_controller.dart';
import 'package:marathon/controllers/mainController/main_controller.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/server/api/api_const.dart';
import '../../data/tools/toast/custom_snackbar.dart';
import '../../domain/entities/aparments/apartments_list.dart';
import '../../domain/use_cases/apartments_use_case/get_apartments_use_case.dart';

class HomeController extends BaseController {
  GetApartmentsUseCase getApartmentsUseCase;
  ApartmentsList? apartmentsList;
  bool isLoading = false;
  int length = 0;

  HomeController(this.getApartmentsUseCase);

  @override
  void onInit() {
    getApartmentsList();
    super.onInit();
  }

  void getApartmentsList() {
    Map<String, dynamic> request = {"cust_id": Get.find<AppHolder>().custId};
    Map<String, dynamic> params = {
      "apikey": Api.apiKey,
      "action": "apartments_get"
    };

    log('Get.find<AppHolder>().custId==========>>>>>${Get.find<AppHolder>().custId}');
    log('params==========>>>>>$params');

    getApartmentsUseCase.invoke(params, request).listen((event) {
      event.when(loading: () {
        isLoading = true;
        update();
      }, content: (response) async {
        apartmentsList = response;
        length = apartmentsList?.data?.apartments?.length ?? 0;
        Get.find<AppHolder>().isSwitch =
            apartmentsList?.data?.apartments?.length == 1 ? false : true;
        if (length == 1) {
          Get.find<MainController>().changePages(
              apartmentsList?.data?.apartments?.first.apartmentId.toString() ??
                  "");
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
}
