import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/social_media/controllers/social_media_controller.dart';

class SocialMediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocialMediaController>(
      () => SocialMediaController(),
    );
  }
}
