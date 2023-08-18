import 'package:app/app/data/stage_model.dart';
import 'package:app/app/services/stage_service.dart';
import 'package:app/app/utils/api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:app/app/widgets/loading.dart';

class StartController extends GetxController {
  final AudioCache audioCache = AudioCache(
    prefix: 'assets/audios/',
  );

  final box = GetStorage();
  RxBool isLoading = false.obs;
  StageModel? stageModel;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    loadstageNow();
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
