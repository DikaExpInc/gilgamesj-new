import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/gallery/controllers/gallery_controller.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryController>(
      () => GalleryController(),
    );
  }
}
