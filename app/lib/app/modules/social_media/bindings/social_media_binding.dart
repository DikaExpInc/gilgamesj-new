import 'package:get/get.dart';

import '../controllers/social_media_controller.dart';

class SocialMediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocialMediaController>(
      () => SocialMediaController(),
    );
  }
}
