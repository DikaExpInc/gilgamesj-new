import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/stage_model.dart';
import '../../../services/stage_service.dart';
import '../../../utils/api.dart';
import '../../../widgets/loading.dart';

class RulesController extends GetxController {
  final box = GetStorage();
  final Map<String, dynamic> rulesData = Get.arguments;
  StageModel? stageModel;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    loadstageNow();
  }

  Future<void> onNext() async {
    if (rulesData['from'] == "start") {
      Get.back();
    } else {
      Get.toNamed(Routes.START);
    }
  }

  loadstageNow() async {
    update();
    showLoading();
    stageModel = await StageApi().loadStageAPI();
    update();
    stopLoading();
    if (stageModel?.statusCode == 200) {
      box.write("background_url",
          "${SharedApi().imageUrl}${stageModel?.background.toString()}");
      box.write("stage_id", stageModel?.sId);
      box.write('tuts', stageModel?.lockCode);
    } else if (stageModel!.statusCode == 204) {
      print("Empty");
    } else if (stageModel!.statusCode == 404) {
      update();
    } else if (stageModel!.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
