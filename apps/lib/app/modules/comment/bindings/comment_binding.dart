import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/comment/controllers/comment_controller.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentController>(
      () => CommentController(),
    );
  }
}
