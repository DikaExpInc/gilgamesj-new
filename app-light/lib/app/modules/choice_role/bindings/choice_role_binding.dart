import 'package:get/get.dart';

import '../controllers/choice_role_controller.dart';

class ChoiceRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoiceRoleController>(
      () => ChoiceRoleController(),
    );
  }
}
