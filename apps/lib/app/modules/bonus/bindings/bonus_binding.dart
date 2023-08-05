import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/bonus/controllers/bonus_controller.dart';

class BonusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BonusController>(
      () => BonusController(),
    );
  }
}
