import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TicketController extends GetxController {
  //TODO: Implement TicketController

  @override
  void onInit() {
    _startBlinking();
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

  final RxBool isVisible = true.obs;

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  void _startBlinking() {
    Future.delayed(Duration(milliseconds: 500), () {
      toggleVisibility(); // Mengubah visibilitas teks
      _startBlinking(); // Membuat loop kedip
    });
  }
}
