import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/bonus_home/controllers/bonus_home_controller.dart';

class BonusHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BonusHomeController>(
      () => BonusHomeController(),
    );
  }
}
