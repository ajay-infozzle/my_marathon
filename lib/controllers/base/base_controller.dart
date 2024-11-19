import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseController extends GetxController {
  // bag to handle all the subscriptions scoped to this ViewModel
  final subscribe = CompositeSubscription();

  @override
  void dispose() {
    subscribe.clear();
    super.dispose();
  }

}
