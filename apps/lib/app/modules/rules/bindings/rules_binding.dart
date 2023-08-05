import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/rules/controllers/rules_controller.dart';

class RulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RulesController>(
      () => RulesController(),
    );
  }
}
