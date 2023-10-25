import 'package:get/get.dart';

import '../controllers/pre_game_credit_controller.dart';

class PreGameCreditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameCreditController>(
      () => PreGameCreditController(),
    );
  }
}
