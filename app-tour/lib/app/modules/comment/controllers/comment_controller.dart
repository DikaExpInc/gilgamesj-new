import 'package:gilgamesj_tour/app/data/social_media_comment.dart';
import 'package:gilgamesj_tour/app/services/social_media_comment_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/page_all_controller.dart';
import '../../../widgets/loading.dart';

class CommentController extends GetxController {
  final Map<String, dynamic> sosmedData = Get.arguments;
  RxBool isLoading = false.obs;
  final box = GetStorage();
  final PageAllController pageAllController = Get.find<PageAllController>();

  @override
  void onInit() {
    super.onInit();
    loadSocialMediaComment();
  }

  loadSocialMediaComment() async {
    update();
    showLoading();
    SocialMediaCommentListModel socialMediaComment =
        await SocialMediaCommentApi()
            .loadSocialMediaCommentAPI(sosmedData['id']);
    pageAllController.updateSocialMediaComment(socialMediaComment);
    update();
    stopLoading();
    if (socialMediaComment.statusCode == 200) {
    } else if (socialMediaComment.statusCode == 204) {
      print("Empty");
    } else if (socialMediaComment.statusCode == 404) {
      update();
    } else if (socialMediaComment.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
