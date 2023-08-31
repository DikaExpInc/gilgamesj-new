import 'dart:async';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreGameSplashController extends GetxController
    with GetTickerProviderStateMixin {
  late Timer imageTimer;
  var currentImageIndex = 0.obs;

  List<String> images = [
    'assets/images/logo-splash-1.png',
    'assets/images/logo-splash-1.png',
    'assets/images/logo-splash-2.png',
    'assets/images/logo-splash-3.png',
    'assets/images/logo-splash-4.png',
    'assets/images/logo-splash-5.png',
    'assets/images/logo-splash-4.png',
  ];

  RxDouble fadeValue = 1.0.obs;
  late AnimationController fadeAnimationController;

  @override
  void onInit() {
    super.onInit();
    fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    startImageTimer();
  }

  void startImageTimer() {
    imageTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      fadeAnimationController.reverse(); // Start fade out animation
      Future.delayed(Duration(milliseconds: 500), () {
        currentImageIndex.value = (currentImageIndex.value + 1) % images.length;
        fadeAnimationController.forward(from: 0.0); // Start fade in animation
        if (currentImageIndex.value == images.length - 1) {
          Get.offNamed(
            Routes.PRE_GAME_START,
          );
        }
      });
    });
  }

  @override
  void onClose() {
    imageTimer.cancel(); // Stop the timer when closing the controller
    fadeAnimationController.dispose();
    super.onClose();
  }
}
