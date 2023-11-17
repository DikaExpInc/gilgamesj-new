import 'package:gilgamesj_tour/app/controllers/page_all_controller.dart';
import 'package:gilgamesj_tour/app/data/social_media_model.dart';
import 'package:gilgamesj_tour/app/services/social_media_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../widgets/loading.dart';

class SocialMediaController extends GetxController {
  RxBool isLoading = false.obs;
  final box = GetStorage();
  final PageAllController pageAllController = Get.find<PageAllController>();

  @override
  void onInit() {
    super.onInit();
    loadSocialMedia();
  }

  loadSocialMedia() async {
    update();
    showLoading();
    SocialMediaListModel socialMedia =
        await SocialMediaApi().loadSocialMediaAPI();
    pageAllController.updateSocialMedia(socialMedia);
    update();
    stopLoading();
    if (socialMedia.statusCode == 200) {
    } else if (socialMedia.statusCode == 204) {
      print("Empty");
    } else if (socialMedia.statusCode == 404) {
      update();
    } else if (socialMedia.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  Future<void> like(String id) async {
    update();
    showLoading();
    SocialMediaModel socialMedia =
        await SocialMediaApi().likeSocialMediaAPI(id);
    SocialMediaListModel socialMediaList =
        await SocialMediaApi().loadSocialMediaAPI();
    pageAllController.updateSocialMedia(socialMediaList);
    update();
    stopLoading();
    if (socialMedia.statusCode == 200) {
    } else if (socialMedia.statusCode == 204) {
      print("Empty");
    } else if (socialMedia.statusCode == 404) {
      update();
    } else if (socialMedia.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
