import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/player_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../../../widgets/loading.dart';

class ChangePlayerController extends GetxController {
  final box = GetStorage();
  RxBool isLoading = false.obs;
  PlayerListModel? playerListModel;

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
    playerListModel = await AuthApi().loadAllPlayerAPI();
    update();
    stopLoading();
    if (playerListModel?.statusCode == 200) {
    } else if (playerListModel!.statusCode == 204) {
      print("Empty");
    } else if (playerListModel!.statusCode == 404) {
      update();
    } else if (playerListModel!.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
