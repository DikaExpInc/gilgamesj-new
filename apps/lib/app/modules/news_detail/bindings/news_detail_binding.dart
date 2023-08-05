import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/news_detail/controllers/news_detail_controller.dart';

class NewsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailController>(
      () => NewsDetailController(),
    );
  }
}
