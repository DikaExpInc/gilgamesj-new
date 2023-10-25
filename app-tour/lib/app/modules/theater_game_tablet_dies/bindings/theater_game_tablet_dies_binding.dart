import 'package:get/get.dart';

import '../controllers/theater_game_tablet_dies_controller.dart';

class TheaterGameTabletDiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameTabletDiesController>(
      () => TheaterGameTabletDiesController(),
    );
  }
}
