import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/phone/controllers/phone_controller.dart';

class PhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneController>(
      () => PhoneController(),
    );
  }
}
