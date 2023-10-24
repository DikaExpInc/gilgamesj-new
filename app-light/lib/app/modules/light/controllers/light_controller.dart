import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LightController extends GetxController {
  //TODO: Implement LightController

  @override
  void onInit() {
    super.onInit();
    sub = settingStream.listen((event) {
      changeBackgroundColor();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final Stream settingStream =
      Stream.periodic(const Duration(milliseconds: 200), (int count) {
    return count;
  });
  late StreamSubscription sub;

  final List<Color> backgroundColors = [
    Colors.amberAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
  ];
  var currentColorIndex = 0.obs;

  void changeBackgroundColor() {
    currentColorIndex.value =
        (currentColorIndex.value + 1) % backgroundColors.length;
  }
}
