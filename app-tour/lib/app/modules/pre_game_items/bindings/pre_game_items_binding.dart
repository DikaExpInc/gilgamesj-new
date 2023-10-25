import 'package:get/get.dart';

import '../controllers/pre_game_items_controller.dart';

class PreGameItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameItemsController>(
      () => PreGameItemsController(),
    );
  }
}
