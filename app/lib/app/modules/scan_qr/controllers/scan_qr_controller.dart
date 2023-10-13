import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrController extends GetxController {
  var result = Rxn<Barcode>();
  var qrController = Rxn<QRViewController>();
  Map<String, dynamic> arguments = Get.arguments;
  RxBool isWrong = false.obs;

  void onQRViewCreated(QRViewController controller) {
    this.qrController.value = controller;
    controller.scannedDataStream.listen((scanData) {
      if (arguments['id'] == 0) {
        if (scanData.code == "game1") {
          Get.toNamed(Routes.PRE_GAME_PHOTO);
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 1) {
        if (scanData.code == "game2") {
          Get.toNamed(Routes.PRE_GAME_TALKING_VIDEO, arguments: {
            "type": "boat",
          });
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 2) {
        if (scanData.code == "game3") {
          Get.toNamed(Routes.PRE_GAME_TALKING_VIDEO, arguments: {
            "type": "uruk",
          });
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 3) {
        if (scanData.code == "game4") {
          Get.toNamed(Routes.MINI_GAME_MUSIC_GAME, arguments: {
            "type": "ishtar",
            "lock_code": 1234,
            "bg": "assets/images/ishtar_bg.png",
          });
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 4) {
        if (scanData.code == "game5") {
          Get.toNamed(Routes.PRE_GAME_GUESS, arguments: {
            "type": "humbaba",
          });
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 5) {
        if (scanData.code == "game6") {
          Get.toNamed(Routes.MINI_GAME_MUSIC_GAME, arguments: {
            "type": "anu",
          });
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 6) {
        if (scanData.code == "game7") {
          Get.toNamed(Routes.PRE_GAME_GUESS, arguments: {
            "type": "ishtar",
          });
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 7) {
        if (scanData.code == "game8") {
          Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
            "type": "rule1",
          });
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 8) {
        if (scanData.code == "game9") {
          Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
            "type": "rule2",
          });
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 9) {
        if (scanData.code == "game10") {
          Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
            "type": "rule3",
          });
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 10) {
        if (scanData.code == "game11") {
          Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
            "type": "rule4",
          });
        } else {
          isWrong.value = true;
        }
      }
      if (arguments['id'] == 11) {
        if (scanData.code == "game12") {
          Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
            "type": "rule5",
          });
        } else {
          isWrong.value = true;
        }
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    qrController.value?.dispose();
    super.onClose();
  }
}
