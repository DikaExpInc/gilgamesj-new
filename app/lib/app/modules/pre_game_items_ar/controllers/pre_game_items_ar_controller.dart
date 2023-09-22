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
    super.onClose();
    _controllerParticle.dispose();
  }

  Widget get rotatingParticle {
    return RotationTransition(
      turns: _controllerParticle,
      child: Image.asset('assets/images/particle.png'),
    );
  }
}
