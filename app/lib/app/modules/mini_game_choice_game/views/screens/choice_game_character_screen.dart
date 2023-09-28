import 'package:app/app/modules/mini_game_choice_game/controllers/mini_game_choice_game_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class ChoiceGameCharacterScreen extends GetView<MiniGameChoiceGameController> {
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
        color: Color(0xff9B8173),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Obx(
                () => AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: controller.characterSelect.value ==
                          controller
                              .questions[controller.currentIndex.value].title1
                      ? Image.asset(
                          '${controller.questions[controller.currentIndex.value].image1}-active.png',
                          key: ValueKey<int>(1),
                        )
                      : Image.asset(
                          "${controller.questions[controller.currentIndex.value].image1}.png",
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
                  child: controller.characterSelect.value ==
                          controller
                              .questions[controller.currentIndex.value].title2
                      ? Image.asset(
                          "${controller.questions[controller.currentIndex.value].image2}-active.png",
                          key: ValueKey<int>(1),
                        )
                      : Image.asset(
                          "${controller.questions[controller.currentIndex.value].image2}.png",
                          key: ValueKey<int>(2),
                        ),
                ),
              ),
            ),
            Positioned(
              left: mWidth / 6,
              top: mHeight / 5,
              child: Obx(
                () => InkWell(
                  onTap: () => {
                    controller.characterSelect.value =
                        "${controller.questions[controller.currentIndex.value].title1}",
                    // controller.setWidget(LightningGameLightScreen())
                  },
                  child: Container(
                    child: Text(
                      "${controller.questions[controller.currentIndex.value].title1}",
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
            ),
            Positioned(
              right: mWidth / 6,
              bottom: mHeight / 5,
              child: Obx(
                () => InkWell(
                  onTap: () => {
                    controller.characterSelect.value =
                        "${controller.questions[controller.currentIndex.value].title2}",
                    // controller.setWidget(LightningGameLightScreen())
                  },
                  child: Text(
                    "${controller.questions[controller.currentIndex.value].title2}",
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
                        'CHOICE THIS ONE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 42,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Positioned(
                      top: mHeight / 2,
                      child: InkWell(
                          onTap: () => controller.currentIndex.value ==
                                  controller.questions.length - 1
                              ? Get.offNamed(Routes.MINI_GAME_CHOICE_GAME_DONE)
                              : controller.goToNextQuestion(),
                          child: Image.asset('assets/images/oke_button.png'))),
            ),
          ],
        ),
      ),
    );
  }
}
