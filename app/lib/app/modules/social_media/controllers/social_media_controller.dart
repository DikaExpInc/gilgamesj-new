import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SocialMediaController extends GetxController {
  RxBool isLoading = false.obs;
  var tasks = RxList<Map<String, dynamic>>([]);
  var doneTasks = RxList<Map<String, dynamic>>([]);
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }
}
