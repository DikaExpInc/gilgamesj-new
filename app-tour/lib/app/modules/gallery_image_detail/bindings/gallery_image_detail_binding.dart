import 'package:get/get.dart';

import '../controllers/gallery_image_detail_controller.dart';

class GalleryImageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryImageDetailController>(
      () => GalleryImageDetailController(),
    );
  }
}
