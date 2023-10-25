import 'package:get/get.dart';

import '../controllers/lock_music_controller.dart';

class LockMusicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LockMusicController>(
      () => LockMusicController(),
    );
  }
}
