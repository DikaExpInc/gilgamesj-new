import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MapController extends GetxController {
  RxBool isBottomSheetVisible = false.obs;
  RxBool isLoading = false.obs;
  var tasks = RxList<Map<String, dynamic>>([]);
  var doneTasks = RxList<Map<String, dynamic>>([]);
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  void toggleBottomSheetVisibility() {
    isBottomSheetVisible.value = !isBottomSheetVisible.value;
  }
}
