import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/gallery_video_detail/controllers/gallery_video_detail_controller.dart';

class GalleryVideoDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryVideoDetailController>(
      () => GalleryVideoDetailController(),
    );
  }
}
