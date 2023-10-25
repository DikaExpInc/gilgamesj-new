import 'package:get/get.dart';

import '../controllers/gallery_video_detail_controller.dart';

class GalleryVideoDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryVideoDetailController>(
      () => GalleryVideoDetailController(),
    );
  }
}
