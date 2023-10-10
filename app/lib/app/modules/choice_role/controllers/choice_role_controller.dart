import 'package:app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChoiceRoleController extends GetxController {
  //TODO: Implement ChoiceRoleController

  RxString selectedRole = "".obs;

  void chooseRole(String role) {
    selectedRole.value = role;
  }

  void nextStep() {
    if (selectedRole.value == "late") {
      GetStorage().write('role', 'disability');
    } else {
      GetStorage().write('role', selectedRole.value);
    }
    Get.offNamed(Routes.PRE_GAME_START);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
