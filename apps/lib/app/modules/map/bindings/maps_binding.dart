import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/map/controllers/maps_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(
      () => MapsController(),
    );
  }
}
