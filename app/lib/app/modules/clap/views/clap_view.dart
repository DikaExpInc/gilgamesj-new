import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import 'package:get/get.dart';

import '../controllers/clap_controller.dart';

class ClapView extends GetView<ClapController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: mWidth,
              height: mHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0), BlendMode.srcOver),
                  image: AssetImage("assets/images/background2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please Clap",
                    style: TextStyle(
                      fontSize: 54,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Do clap more harder",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Obx(
                    () => FAProgressBar(
                      currentValue: controller.valueClap.value.toDouble(),
                      displayText: '%',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
