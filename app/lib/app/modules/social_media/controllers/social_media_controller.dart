import 'package:app/app/data/social_media_model.dart';
import 'package:app/app/services/social_media_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/loading.dart';

class SocialMediaController extends GetxController {
  RxBool isLoading = false.obs;
  var tasks = RxList<Map<String, dynamic>>([]);
  var doneTasks = RxList<Map<String, dynamic>>([]);

  final box = GetStorage();
  SocialMediaListModel? socialMedia;

  Future<void> onNext() async {
    Get.toNamed(Routes.INTRODUCTION);
  }

  @override
  void onInit() {
    super.onInit();
    loadPlayers();
  }

  loadPlayers() async {
    update();
    showLoading();
    socialMedia = await SocialMediaApi().loadSocialMediaAPI();
    update();
    stopLoading();
    if (socialMedia?.statusCode == 200) {
    } else if (socialMedia!.statusCode == 204) {
      print("Empty");
    } else if (socialMedia!.statusCode == 404) {
      update();
    } else if (socialMedia!.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
