import 'dart:async';

import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:gilgamesj_tour/app/widgets/dialog/items_dialog.dart';
import 'package:get/get.dart';

class PreGameItemsController extends GetxController {
  RxInt selectedItemIndex = 0.obs;

  final RxList<bool> tappedList = RxList<bool>.of([false, false, false, false]);
  RxBool isPositionedVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  // Metode untuk mengatur waktu tampil dan hilangnya Positioned secara berulang
  void _startTimer() {
    _togglePositionedVisibility();

    // Fungsi rekursif untuk menjalankan timer secara berulang
    Future.delayed(Duration(seconds: 10), () {
      _startTimer();
    });
  }

  void _togglePositionedVisibility() {
    isPositionedVisible.value = true; // Tampilkan Positioned
    Future.delayed(Duration(seconds: 3), () {
      isPositionedVisible.value =
          false; // Sembunyikan Positioned setelah 10 detik
    });
  }

  bool get isAllTapped =>
      tappedList[0] && tappedList[1] && tappedList[2] && tappedList[3];

  void toggleTap(int index, {bool isTapped = true}) {
    tappedList[index - 1] = isTapped;

    if (isAllTapped) {
      tappedList[0] = false;
      tappedList[1] = false;
      tappedList[2] = false;
      tappedList[3] = false;
      Get.toNamed(Routes.PRE_GAME_ITEMS_AR);
    }
  }

  void showItemDialog(
      {String image = '', required String title, required String description}) {
    Get.dialog(
      ItemsDialog(
        image: image,
        title: title,
        description: description,
      ),
    );
  }
}
