import 'package:get/get.dart';

import '../controllers/pre_game_spirit_realm_controller.dart';

class PreGameSpiritRealmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameSpiritRealmController>(
      () => PreGameSpiritRealmController(),
    );
  }
}
