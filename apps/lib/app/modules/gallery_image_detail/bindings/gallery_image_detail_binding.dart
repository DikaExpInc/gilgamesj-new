import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/gallery_image_detail/controllers/gallery_image_detail_controller.dart';

class GalleryImageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryImageDetailController>(
      () => GalleryImageDetailController(),
    );
  }
}
