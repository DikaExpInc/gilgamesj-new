import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_music_game_controller.dart';

// ignore: must_be_immutable
class MiniGameMusicGameView extends GetView<MiniGameMusicGameController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<MiniGameMusicGameController>(builder: (controller) {
      return Scaffold(
          body: Container(
              width: mWidth,
              height: mHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.blueAccent.withOpacity(0), BlendMode.srcOver),
                  image: AssetImage(controller.arguments['type'] != ''
                      ? "${controller.arguments['bg']}"
                      : "assets/images/bg_music.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Positioned(
                  //   width: mWidth,
                  //   top: 50,
                  //   child: Obx(() => Center(
                  //           child: Text(
                  //         '${controller.key_tuts}',
                  //         style: TextStyle(
                  //           fontFamily: 'Centrion',
                  //           fontSize: 42,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ))),
                  // ),
                  Positioned(
                    width: mWidth,
                    top: 50,
                    child: Obx(() => Center(
                            child: Image.asset(''))),
                  ),
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
                            final AudioCache audioCache =
                                AudioCache(prefix: 'assets/audios/tuts/');
                            audioCache.play('7.mp3');
                            controller.increment(7);
                          },
                          child: Image.asset(
                            'assets/images/bg_music_tap1.png', // Ganti dengan path gambar yang sesuai
                            width: mWidth / 5, // Sesuaikan dengan lebar gambar
                            height:
                                mWidth / 5, // Sesuaikan dengan tinggi gambar
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final AudioCache audioCache =
                                AudioCache(prefix: 'assets/audios/tuts/');
                            audioCache.play('8.mp3');
                            controller.increment(8);
                          },
                          child: Image.asset(
                            'assets/images/bg_music_tap1.png', // Ganti dengan path gambar yang sesuai
                            width: mWidth / 5, // Sesuaikan dengan lebar gambar
                            height:
                                mWidth / 5, // Sesuaikan dengan tinggi gambar
                          ),
                        ),
                        // Tambahkan teks atau widget lain jika diperlukan
                      ],
                    ),
                  ),

                  // Kolom kedua
                  Positioned(
                    width: mWidth,
                    bottom: mHeight / 7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            final AudioCache audioCache =
                                AudioCache(prefix: 'assets/audios/tuts/');
                            audioCache.play('3.mp3');
                            controller.increment(3);
                          },
                          child: Image.asset(
                            'assets/images/bg_music_tap3.png', // Ganti dengan path gambar yang sesuai
                            width: mWidth / 7, // Sesuaikan dengan lebar gambar
                            height:
                                mWidth / 7, // Sesuaikan dengan tinggi gambar
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final AudioCache audioCache =
                                AudioCache(prefix: 'assets/audios/tuts/');
                            audioCache.play('4.mp3');
                            controller.increment(4);
                          },
                          child: Image.asset(
                            'assets/images/bg_music_tap2.png', // Ganti dengan path gambar yang sesuai
                            width: mWidth / 6, // Sesuaikan dengan lebar gambar
                            height:
                                mWidth / 6, // Sesuaikan dengan tinggi gambar
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final AudioCache audioCache =
                                AudioCache(prefix: 'assets/audios/tuts/');
                            audioCache.play('5.mp3');
                            controller.increment(5);
                          },
                          child: Image.asset(
                            'assets/images/bg_music_tap2.png', // Ganti dengan path gambar yang sesuai
                            width: mWidth / 6, // Sesuaikan dengan lebar gambar
                            height:
                                mWidth / 6, // Sesuaikan dengan tinggi gambar
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final AudioCache audioCache =
                                AudioCache(prefix: 'assets/audios/tuts/');
                            audioCache.play('6.mp3');
                            controller.increment(6);
                          },
                          child: Image.asset(
                            'assets/images/bg_music_tap3.png', // Ganti dengan path gambar yang sesuai
                            width: mWidth / 7, // Sesuaikan dengan lebar gambar
                            height:
                                mWidth / 7, // Sesuaikan dengan tinggi gambar
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Kolom ketiga
                  Positioned(
                    width: mWidth,
                    bottom: mHeight /
                        4.5, // Sesuaikan dengan posisi horizontal yang diinginkan
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            final AudioCache audioCache =
                                AudioCache(prefix: 'assets/audios/tuts/');
                            audioCache.play('1.mp3');
                            controller.increment(1);
                          },
                          child: Image.asset(
                            'assets/images/bg_music_tap4.png', // Ganti dengan path gambar yang sesuai
                            width: mWidth / 7, // Sesuaikan dengan lebar gambar
                            height:
                                mWidth / 7, // Sesuaikan dengan tinggi gambar
                          ),
                        ),
                        SizedBox(
                          width: mWidth / 50,
                        ),
                        InkWell(
                          onTap: () {
                            final AudioCache audioCache =
                                AudioCache(prefix: 'assets/audios/tuts/');
                            audioCache.play('2.mp3');
                            controller.increment(2);
                          },
                          child: Image.asset(
                            'assets/images/bg_music_tap4.png', // Ganti dengan path gambar yang sesuai
                            width: mWidth / 7, // Sesuaikan dengan lebar gambar
                            height:
                                mWidth / 7, // Sesuaikan dengan tinggi gambar
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )));
    });
  }
}
