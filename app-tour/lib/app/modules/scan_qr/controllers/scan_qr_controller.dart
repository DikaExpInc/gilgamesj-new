import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var result = Rxn<Barcode>();
  var qrController = Rxn<QRViewController>();
  Map<String, dynamic> arguments = Get.arguments;
  RxBool isWrong = false.obs;
  RxBool isWrongFill = false.obs;
  TextEditingController inputCodeController = TextEditingController();

  late TabController tabController;

  void onQRViewCreated(QRViewController controller) {
    this.qrController.value = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        if (arguments['id'] == 3) {
          if (scanData.code == "129371") {
            Get.toNamed(Routes.MINI_GAME_MUSIC_GAME, arguments: {
              "id": 4,
              "type": "ishtar",
              "lock_code": 1234,
              "bg": "assets/images/ishtar-bg.png",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 4) {
          if (scanData.code == "102934") {
            Get.toNamed(Routes.PRE_GAME_GUESS, arguments: {
              "id": 5,
              "game": "game5",
              "type": "humbaba",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 5) {
          if (scanData.code == "578341") {
            Get.toNamed(Routes.PRE_GAME_GUESS, arguments: {
              "id": 6,
              "game": "game6",
              "type": "hemelstier",
            });
          } else {
            isWrong.value = true;
          }
        }
        // if (arguments['id'] == 6) {
        //   if (scanData.code == "123887") {
        //     Get.toNamed(Routes.PRE_GAME_GUESS, arguments: {
        //       "id": 7,
        //       "game": "game7",
        //       "type": "ishtar",
        //     });
        //   } else {
        //     isWrong.value = true;
        //   }
        // }
        if (arguments['id'] == 7) {
          if (scanData.code == "282302") {
            Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
              "id": 8,
              "game": "rule",
              "type": "rule1",
            });
          } else {
            isWrong.value = true;
          }
        }
      },
    );
  }

  @override
  void onInit() {
    tabController = new TabController(vsync: this, length: 1);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    qrController.value?.dispose();
    super.onClose();
  }

  void onSubmit() {
    if (arguments['id'] == 3) {
      if (inputCodeController.text == "129371") {
        Get.toNamed(Routes.MINI_GAME_MUSIC_GAME, arguments: {
          "id": 4,
          "type": "ishtar",
          "lock_code": 1234,
          "bg": "assets/images/ishtar-bg.png",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 4) {
      if (inputCodeController.text == "102934") {
        Get.toNamed(Routes.PRE_GAME_GUESS, arguments: {
          "id": 5,
          "game": "game5",
          "type": "humbaba",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 5) {
      if (inputCodeController.text == "578341") {
        Get.toNamed(Routes.PRE_GAME_GUESS, arguments: {
          "id": 6,
          "game": "game6",
          "type": "hemelstier",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    // if (arguments['id'] == 6) {
    //   if (inputCodeController.text == "123887") {
    //     Get.toNamed(Routes.PRE_GAME_GUESS, arguments: {
    //       "id": 7,
    //       "game": "game7",
    //       "type": "ishtar",
    //     });
    //   } else {
    //     isWrongFill.value = true;
    //   }
    // }
    if (arguments['id'] == 7) {
      if (inputCodeController.text == "282302") {
        Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
          "id": 8,
          "game": "rule",
          "type": "rule1",
        });
      } else {
        isWrongFill.value = true;
      }
    }
  }
}
