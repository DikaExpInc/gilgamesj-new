import 'package:gilgamesj_tour/app/data/map_model.dart';
import 'package:gilgamesj_tour/app/services/map_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/page_all_controller.dart';
import '../../../widgets/loading.dart';

class MapController extends GetxController {
  RxBool isBottomSheetVisible = false.obs;
  RxBool isLoading = false.obs;
  var tasks = RxList<Map<String, dynamic>>([]);
  var doneTasks = RxList<Map<String, dynamic>>([]);
  final box = GetStorage();
  final PageAllController pageAllController = Get.find<PageAllController>();

  @override
  void onInit() {
    super.onInit();
    loadMap();
  }

  void toggleBottomSheetVisibility() {
    isBottomSheetVisible.value = !isBottomSheetVisible.value;
  }

  loadMap() async {
    update();
    showLoading();
    MapListModel maps = await MapApi().loadMapAPI();
    pageAllController.updateMap(maps);
    update();
    stopLoading();
    if (maps.statusCode == 200) {
    } else if (maps.statusCode == 204) {
      print("Empty");
    } else if (maps.statusCode == 404) {
      update();
    } else if (maps.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
