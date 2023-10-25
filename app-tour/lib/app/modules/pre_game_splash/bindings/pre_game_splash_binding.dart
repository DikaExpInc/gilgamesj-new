import 'package:get/get.dart';

import '../controllers/pre_game_splash_controller.dart';

class PreGameSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameSplashController>(
      () => PreGameSplashController(),
    );
  }
}
