import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreGameItemsArController extends GetxController
    with GetTickerProviderStateMixin {
  RxInt selectedItemIndex = 0.obs;
  late AnimationController _controllerParticle;

  @override
  void onInit() {
    super.onInit();
    _controllerParticle = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();
  }

  @override
  void onClose() {
    _controllerParticle.dispose();
    super.onClose();
  }

  Widget get rotatingParticle {
    return RotationTransition(
      turns: _controllerParticle,
      child: Image.asset('assets/images/particle.png'),
    );
  }

  void onSubmit() {
    Get.toNamed(Routes.SCAN_QR, arguments: {
      "id": selectedItemIndex.value,
    });
  }
}
