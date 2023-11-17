import 'package:gilgamesj_tour/app/modules/blank/controllers/blank_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class BlankView extends GetView<BlankController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<BlankController>(builder: (controller) {
      return Scaffold(
        body: Container(
          width: mWidth,
          height: mHeight,
          color: Colors.black,
        ),
      );
    });
  }
}
