import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ShowVersionController extends GetxController {
  RxString myIP = "".obs;
  @override
  Future<void> onInit() async {
    final info = NetworkInfo();
    myIP.value = (await info.getWifiIP())!;
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
