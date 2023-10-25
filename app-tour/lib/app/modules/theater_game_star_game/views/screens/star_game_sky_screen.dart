import 'package:app/app/modules/theater_game_star_game/controllers/theater_game_star_game_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class StarGameSkyScreen extends GetView<TheaterGameStarGameController> {
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
            Positioned(
              width: mWidth,
              top: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text(
                      'maak het geluid in de nacht',
                      style: const TextStyle(
                        fontFamily: 'Centrion',
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth,
                  top: mHeight /
                      2.2, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("diertje.wav");
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
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth / 1.2,
                  top: mHeight / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("kikkers.wav");
                            controller.selectedImageIndex.value = 1;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 1
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 10,
                            );
                          }),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("krekels.wav");
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
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth / 1.2,
                  top: mHeight /
                      20, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("takjes geruis.wav");
                            controller.selectedImageIndex.value = 3;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 3
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 2,
                            );
                          }),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("uil.wav");
                            controller.selectedImageIndex.value = 4;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 4
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 2,
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
                  top: mHeight /
                      30, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("vogels.wav");
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
