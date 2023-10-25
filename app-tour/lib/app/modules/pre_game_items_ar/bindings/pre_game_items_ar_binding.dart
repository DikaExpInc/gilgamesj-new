import 'package:get/get.dart';

import '../controllers/pre_game_items_ar_controller.dart';

class PreGameItemsArBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameItemsArController>(
      () => PreGameItemsArController(),
    );
  }
}
