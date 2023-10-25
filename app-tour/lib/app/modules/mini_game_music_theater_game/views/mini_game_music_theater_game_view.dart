import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_music_theater_game_controller.dart';

// ignore: must_be_immutable
class MiniGameMusicTheaterGameView
    extends GetView<MiniGameMusicTheaterGameController> {
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
            colorFilter: ColorFilter.mode(
                Colors.blueAccent.withOpacity(0), BlendMode.srcOver),
            image: AssetImage("assets/images/sunset_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
              child: Obx(() {
                final remainingSeconds = controller.currentTimer.value;
                final progressValue =
                    remainingSeconds / 13; // Hitung nilai progres
                return Container(
                  width: mWidth,
                  height: 10,
                  child: LinearProgressIndicator(
                    value:
                        progressValue, // Nilai progres dihitung berdasarkan sisa waktu
                    backgroundColor:
                        Colors.grey, // Warna latar belakang progress bar
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white), // Warna progress bar
                  ),
                );
              }),
            ),
            Obx(
              () => Visibility(
                visible: !controller.showButtons.value,
                child: Positioned(
                  top: mHeight / 5,
                  child: Center(
                    child: Stack(
                      children: [
                        Obx(() {
                          final selectedImageIndex =
                              controller.selectedImageIndex.value;
                          Widget imageWidget;
                          switch (selectedImageIndex) {
                            case 0:
                              imageWidget = controller
                                  .rotatingDisk('assets/images/music_bg_1.png');
                              break;
                            case 1:
                              imageWidget = imageWidget = controller
                                  .rotatingDisk('assets/images/music_bg_2.png');
                              break;
                            case 2:
                              imageWidget = imageWidget = controller
                                  .rotatingDisk('assets/images/music_bg_3.png');
                              break;
                            case 3:
                              imageWidget = imageWidget = controller
                                  .rotatingDisk('assets/images/music_bg_4.png');
                              break;
                            case 4:
                              imageWidget = imageWidget = controller
                                  .rotatingDisk('assets/images/music_bg_5.png');
                              break;
                            case 5:
                              imageWidget = imageWidget = controller
                                  .rotatingDisk('assets/images/music_bg_6.png');
                              break;
                            case 6:
                              imageWidget = imageWidget = controller
                                  .rotatingDisk('assets/images/music_bg_7.png');
                              break;
                            case 7:
                              imageWidget = imageWidget = controller
                                  .rotatingDisk('assets/images/music_bg_8.png');
                              break;
                            default:
                              imageWidget = imageWidget = controller
                                  .rotatingDisk('assets/images/music_bg_1.png');
                              break;
                          }
                          return imageWidget;
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                    bottom: -20,
                    child: Center(
                      child: Image.asset(
                        'assets/images/bottom-music-group.png', // Ganti dengan path gambar yang sesuai
                        width: mWidth, // Sesuaikan dengan lebar gambar
                      ),
                    )),
              ),
            ),
            // Kolom pertama
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth,
                  bottom: mHeight /
                      6, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("Bass.mp3");
                            controller.selectedImageIndex.value = 0;
                            controller.showButtons.value = false;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 0
                                  ? 'assets/images/music_button_1_active.png'
                                  : 'assets/images/music_button_1.png',
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
                            controller.playAudio("Choir 1.mp3");
                            controller.selectedImageIndex.value = 1;
                            controller.showButtons.value = false;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 1
                                  ? 'assets/images/music_button_2_active.png'
                                  : 'assets/images/music_button_2.png',
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
                            controller.playAudio("Choir 2.mp3");
                            controller.selectedImageIndex.value = 2;
                            controller.showButtons.value = false;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 2
                                  ? 'assets/images/music_button_3_active.png'
                                  : 'assets/images/music_button_3.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("Claps.mp3");
                            controller.selectedImageIndex.value = 3;
                            controller.showButtons.value = false;
                          },
                          child: Obx(() {
                            return controller.selectedImageIndex.value == 3
                                ? Image.asset(
                                    'assets/images/music_button_4_active.png',
                                    width: mWidth / 4,
                                    height: mWidth / 4,
                                  )
                                : Image.asset(
                                    'assets/images/music_button_4.png',
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
            // Kolom kedua
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth,
                  bottom: mHeight /
                      20, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 80, left: 30),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("Hats.mp3");
                            controller.selectedImageIndex.value = 4;
                            controller.showButtons.value = false;
                          },
                          child: Obx(() {
                            return controller.selectedImageIndex.value == 4
                                ? Image.asset(
                                    'assets/images/music_button_5_active.png',
                                    width: mWidth / 4,
                                    height: mWidth / 4,
                                  )
                                : Image.asset(
                                    'assets/images/music_button_5.png',
                                    width: mWidth / 5,
                                    height: mWidth / 5,
                                  );
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 60),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("Kick 1.mp3");
                            controller.selectedImageIndex.value = 5;
                            controller.showButtons.value = false;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 5
                                  ? 'assets/images/music_button_6_active.png'
                                  : 'assets/images/music_button_6.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 80, right: 30),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("Melody Strings.mp3");
                            controller.selectedImageIndex.value = 6;
                            controller.showButtons.value = false;
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.selectedImageIndex.value == 6
                                  ? 'assets/images/music_button_7_active.png'
                                  : 'assets/images/music_button_7.png',
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
            // Kolom ketiga
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth,
                  bottom: mHeight /
                      50, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.playAudio("Sitar.mp3");
                          controller.selectedImageIndex.value = 7;
                          controller.showButtons.value = false;
                        },
                        child: Obx(() {
                          return Image.asset(
                            controller.selectedImageIndex.value == 7
                                ? 'assets/images/music_button_8_active.png'
                                : 'assets/images/music_button_8.png',
                            width: mWidth / 5,
                            height: mWidth / 5,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: !controller.showButtons.value,
                child: Positioned(
                  bottom: mHeight / 15,
                  child: InkWell(
                    onTap: () {
                      controller.showButtons.value = true;
                      controller.audioPlayer.stop();
                      controller.audioFile.value = "";
                    },
                    child: Text(
                      "Terug",
                      style: TextStyle(
                        fontFamily: 'Centrion',
                        fontSize: 42,
                        color: Colors.white,
                      ),
                    ),
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
