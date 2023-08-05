import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/introduction/controllers/introduction_controller.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<IntroductionController>(
    //   () => IntroductionController(),
    // );
    Get.create(() => IntroductionController());
  }
}
