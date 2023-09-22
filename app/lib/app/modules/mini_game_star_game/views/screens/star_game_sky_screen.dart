import 'package:app/app/modules/mini_game_lightning_game/controllers/mini_game_lightning_game_controller.dart';
import 'package:app/app/modules/mini_game_lightning_game/views/screens/lightning_game_light_screen.dart';
import 'package:app/app/modules/mini_game_star_game/controllers/mini_game_star_game_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class StarGameSkyScreen extends GetView<MiniGameStarGameController> {
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/star_sky_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth,
                  bottom: mHeight /
                      6, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("frog.mp3");
                            controller.selectedImageIndex.value = 0;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 0
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("campfire.mp3");
                            controller.selectedImageIndex.value = 1;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 1
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth,
                  bottom: mHeight /
                      2, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("gecko.mp3");
                            controller.selectedImageIndex.value = 2;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 2
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("cricket-sound-113945.mp3");
                            controller.selectedImageIndex.value = 3;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 3
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth,
                  top: 0, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("night-ambience.mp3");
                            controller.selectedImageIndex.value = 4;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 4
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("night-woods.mp3");
                            controller.selectedImageIndex.value = 5;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 5
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
