import 'package:app/app/modules/mini_game_lightning_game/controllers/mini_game_lightning_game_controller.dart';
import 'package:app/app/modules/mini_game_lightning_game/views/screens/lightning_game_light_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class LightningGameCharacterScreen
    extends GetView<MiniGameLightningGameController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: mWidth,
        height: mHeight,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Obx(
                () => AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: controller.characterSelect.value == "Gilgamesj"
                      ? Image.asset(
                          'assets/images/gilgamesj-active.png',
                          key: ValueKey<int>(1),
                        )
                      : Image.asset(
                          "assets/images/gilgamesj.png",
                          key: ValueKey<int>(2),
                        ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Obx(
                () => AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: controller.characterSelect.value == "Enkidu"
                      ? Image.asset(
                          "assets/images/enkidu-active.png",
                          key: ValueKey<int>(1),
                        )
                      : Image.asset(
                          "assets/images/enkidu.png",
                          key: ValueKey<int>(2),
                        ),
                ),
              ),
            ),
            Positioned(
              left: mWidth / 6,
              top: mHeight / 5,
              child: InkWell(
                onTap: () => {
                  controller.characterSelect.value = "Gilgamesj",
                  // controller.setWidget(LightningGameLightScreen())
                },
                child: Container(
                  child: Text(
                    "Gilgamesj",
                    style: TextStyle(
                      fontFamily: 'Centrion',
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: mWidth / 6,
              bottom: mHeight / 5,
              child: InkWell(
                onTap: () => {
                  controller.characterSelect.value = "Enkidu",
                  // controller.setWidget(LightningGameLightScreen())
                },
                child: Text(
                  "Enkidu",
                  style: TextStyle(
                    fontFamily: 'Centrion',
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Obx(() {
              return Transform.rotate(
                angle: 35 *
                    3.14159265359 /
                    180, // Mengonversi sudut dari derajat ke radian
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: 20,
                  height: controller.containerWidth.value,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xffD0891E),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffD0891E),
                        blurRadius: 10.0, // Jarak penyebaran efek glow
                        spreadRadius: 5.0, // Jarak penyebaran efek glow
                      ),
                    ],
                  ),
                ),
              );
            }),
            Obx(
              () => controller.characterSelect == ""
                  ? Positioned(
                      top: mHeight / 2,
                      child: Text(
                        'Wie kies jij?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 42,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  : Positioned(
                      top: mHeight / 2,
                      child: InkWell(
                          onTap: () =>
                              controller.setWidget(LightningGameLightScreen()),
                          child: Image.asset('assets/images/oke_button.png'))),
            ),
          ],
        ),
      ),
    );
  }
}
