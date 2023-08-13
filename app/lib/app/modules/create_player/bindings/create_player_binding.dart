import 'package:get/get.dart';

import '../controllers/create_player_controller.dart';

class CreatePlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePlayerController>(
      () => CreatePlayerController(),
    );
  }
}
