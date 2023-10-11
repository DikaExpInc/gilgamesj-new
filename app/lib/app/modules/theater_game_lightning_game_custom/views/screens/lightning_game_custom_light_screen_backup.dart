import 'package:app/app/modules/theater_game_lightning_game_custom/controllers/theater_game_lightning_game_custom_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class LightningGameCustomLightScreen
    extends GetView<TheaterGameLightningGameCustomController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Obx(
        () => Container(
          width: mWidth,
          height: mHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.blueAccent.withOpacity(0), BlendMode.srcOver),
              image: !controller.isShaking.value
                  ? AssetImage("assets/images/light_bg.png")
                  : AssetImage("assets/images/color_white.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: mHeight / 20,
                child: Text(
                  "Schud en geef licht",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Centrion',
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Obx(() => controller.isShaking.value
                    ? Image.asset(
                        "assets/images/torch_on.png",
                        height: mHeight / 2,
                      )
                    : Image.asset(
                        "assets/images/torch_off.png",
                        height: mHeight / 2,
                      )),
              ),
              Obx(
                () => !controller.isShaking.value
                    ? Positioned(
                        bottom: mHeight / 20,
                        child: Column(
                          children: [
                            AnimatedBuilder(
                              animation: controller.animation,
                              builder: (context, child) {
                                return Transform.translate(
                                    offset:
                                        Offset(0, controller.animation.value),
                                    child:
                                        Image.asset('assets/images/arrow.png'));
                              },
                            ),
                            Text(
                              "Til de tablet op\nen schud deze",
                              style: TextStyle(
                                fontFamily: 'Centrion',
                                fontSize: 42,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
