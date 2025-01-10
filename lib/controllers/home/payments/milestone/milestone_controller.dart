import 'package:get/get.dart';
import 'package:marathon/controllers/base/base_controller.dart';
import '../../../../domain/entities/aparments/apartment_details/milestone.dart';
import '../../../mainController/main_controller.dart';

class MileStoneController extends BaseController {
  bool openMileStone = false;
  bool openBooking = false;
  bool openComp = false;
  bool openInternal = false;
  bool isMileStonePaid = true;
  List openIndex = [];
  MainController mainController = MainController();

  // List<Receipt> listRecept = [];
  List<Milestone> milestone = [];

  void openTab(index) {
    if (openIndex.contains(index)) {
      openIndex.remove(index);
    } else {
      openIndex.add(index);
    }
    update();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      milestone = Get.arguments;
      // Get.log(milestone.toString());
      update();
    }

    super.onInit();
  }

  void openMileStoneDetail(int v) {
    if (v == 0) {
      openMileStone = !openMileStone;
    } else if (v == 1) {
      openBooking = !openBooking;
    } else if (v == 2) {
      openComp = !openComp;
    } else {
      openInternal = !openInternal;
    }
    update();
  }
}
