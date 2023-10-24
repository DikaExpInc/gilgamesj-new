import 'package:get/get.dart';

import '../controllers/scan_ar_controller.dart';

class ScanArBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanArController>(
      () => ScanArController(),
    );
  }
}
