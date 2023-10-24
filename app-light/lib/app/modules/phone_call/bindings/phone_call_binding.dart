import 'package:get/get.dart';

import '../controllers/phone_call_controller.dart';

class PhoneCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneCallController>(
      () => PhoneCallController(),
    );
  }
}
