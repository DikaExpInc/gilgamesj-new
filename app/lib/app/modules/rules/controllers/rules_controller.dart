import 'package:app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RulesController extends GetxController {
  final box = GetStorage();
  final Map<String, dynamic> rulesData = Get.arguments;

  Future<void> onNext() async {
    if (rulesData['from'] == "start") {
      Get.back();
    } else {
      Get.toNamed(Routes.START);
    }
  }
}
