import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/light_controller.dart';

class LightView extends GetView<LightController> {
  const LightView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.backgroundColors[controller.currentColorIndex.value],
        body: Center(),
      ),
    );
  }
}
