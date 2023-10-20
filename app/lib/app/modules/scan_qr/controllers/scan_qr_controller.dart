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
        if (arguments['id'] == 0) {
          if (scanData.code == "172836") {
            Get.toNamed(Routes.PRE_GAME_PHOTO);
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 1) {
          if (scanData.code == "192302") {
            Get.toNamed(Routes.SCAN_AR, arguments: {
              "type": "boat",
              "link": "/gilgamesj/ship",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 2) {
          if (scanData.code == "829361") {
            Get.toNamed(Routes.SCAN_AR, arguments: {
              "type": "wall",
              "link": "/gilgamesj/wall",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 3) {
          if (scanData.code == "129371") {
            Get.toNamed(Routes.MINI_GAME_MUSIC_GAME, arguments: {
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
              "game": "game5",
              "type": "humbaba",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 5) {
          if (scanData.code == "172389") {
            Get.toNamed(Routes.MINI_GAME_MUSIC_GAME, arguments: {
              "type": "anu",
              "lock_code": 1234,
              "bg": "assets/images/annu-bg.png",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 6) {
          if (scanData.code == "123887") {
            Get.toNamed(Routes.PRE_GAME_GUESS, arguments: {
              "game": "game7",
              "type": "ishtar",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 7) {
          if (scanData.code == "282302") {
            Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
              "game": "rule",
              "type": "rule1",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 8) {
          if (scanData.code == "281293") {
            Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
              "game": "rule",
              "type": "rule2",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 9) {
          if (scanData.code == "490127") {
            Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
              "game": "rule",
              "type": "rule3",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 10) {
          if (scanData.code == "760293") {
            Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
              "game": "rule",
              "type": "rule4",
            });
          } else {
            isWrong.value = true;
          }
        }
        if (arguments['id'] == 11) {
          if (scanData.code == "937260") {
            Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
              "game": "rule",
              "type": "rule5",
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
    tabController = new TabController(vsync: this, length: 2);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    qrController.value?.dispose();
    super.onClose();
  }

  void onSubmit() {
    if (arguments['id'] == 0) {
      if (inputCodeController.text == "172836") {
        Get.toNamed(Routes.PRE_GAME_PHOTO);
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 1) {
      if (inputCodeController.text == "192302") {
        Get.toNamed(Routes.SCAN_AR, arguments: {
          "type": "boat",
          "link": "/gilgamesj/boat",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 2) {
      if (inputCodeController.text == "829361") {
        Get.toNamed(Routes.SCAN_AR, arguments: {
          "type": "wall",
          "link": "/gilgamesj/wall",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 3) {
      if (inputCodeController.text == "129371") {
        Get.toNamed(Routes.MINI_GAME_MUSIC_GAME, arguments: {
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
          "game": "game5",
          "type": "humbaba",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 5) {
      if (inputCodeController.text == "172389") {
        Get.toNamed(Routes.MINI_GAME_MUSIC_GAME, arguments: {
          "type": "anu",
          "lock_code": 1234,
          "bg": "assets/images/annu-bg.png",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 6) {
      if (inputCodeController.text == "123887") {
        Get.toNamed(Routes.PRE_GAME_GUESS, arguments: {
          "game": "game7",
          "type": "ishtar",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 7) {
      if (inputCodeController.text == "282302") {
        Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
          "game": "rule",
          "type": "rule1",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 8) {
      if (inputCodeController.text == "281293") {
        Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
          "game": "rule",
          "type": "rule2",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 9) {
      if (inputCodeController.text == "490127") {
        Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
          "game": "rule",
          "type": "rule3",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 10) {
      if (inputCodeController.text == "760293") {
        Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
          "game": "rule",
          "type": "rule4",
        });
      } else {
        isWrongFill.value = true;
      }
    }
    if (arguments['id'] == 11) {
      if (inputCodeController.text == "937260") {
        Get.toNamed(Routes.MINI_GAME_SHAKE_GAME, arguments: {
          "game": "rule",
          "type": "rule5",
        });
      } else {
        isWrongFill.value = true;
      }
    }
  }
}
