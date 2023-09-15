import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_music_theater_game_controller.dart';

class PreGameMusicTheaterGameView
    extends GetView<PreGameMusicTheaterGameController> {
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
                        Colors.blue), // Warna progress bar
                  ),
                );
              }),
            ),
            Positioned(
              left: mWidth / 2.5,
              top: mHeight / 2.5,
              child: Center(
                child: Obx(() {
                  final selectedImageIndex =
                      controller.selectedImageIndex.value;
                  Widget imageWidget;
                  switch (selectedImageIndex) {
                    case 0:
                      imageWidget = Image.asset(
                        'assets/images/music_bg_1.png',
                        width: mWidth / 5,
                        height: mWidth / 5,
                      );
                      break;
                    case 1:
                      imageWidget = Image.asset(
                        'assets/images/music_bg_2.png',
                        width: mWidth / 5,
                        height: mWidth / 5,
                      );
                      break;
                    case 2:
                      imageWidget = Image.asset(
                        'assets/images/music_bg_3.png',
                        width: mWidth / 5,
                        height: mWidth / 5,
                      );
                      break;
                    default:
                      imageWidget = Image.asset(
                        'assets/images/music_bg_3.png',
                        width: mWidth / 5,
                        height: mWidth / 5,
                      );
                      break;
                  }
                  return imageWidget;
                }),
              ),
            ),
            Positioned(
                bottom: -20,
                child: Center(
                  child: Image.asset(
                    'assets/images/bottom-music-group.png', // Ganti dengan path gambar yang sesuai
                    width: mWidth, // Sesuaikan dengan lebar gambar
                  ),
                )),
            // Kolom pertama
            Positioned(
              width: mWidth,
              bottom: mHeight /
                  20, // Sesuaikan dengan posisi horizontal yang diinginkan
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      controller.playAudio("Bass.mp3");
                      controller.selectedImageIndex.value = 0;
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
                  InkWell(
                    onTap: () {
                      controller.playAudio("Choir 1.mp3");
                      controller.selectedImageIndex.value = 1;
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
                  InkWell(
                    onTap: () {
                      controller.playAudio("Choir 2.mp3");
                      controller.selectedImageIndex.value = 2;
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
