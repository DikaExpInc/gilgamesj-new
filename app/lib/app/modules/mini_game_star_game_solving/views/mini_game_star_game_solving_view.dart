import 'package:app/app/modules/mini_game_star_game_solving/controllers/mini_game_star_game_solving_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MiniGameStarGameSolvingView
    extends GetView<MiniGameStarGameSolvingController> {
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Obx(() => AnimatedSwitcher(
                  duration: Duration(seconds: 5),
                  child: controller.doneGame.value
                      ? Container(
                          width: mWidth,
                          height: mHeight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/sunrise_bg.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          key: ValueKey<int>(1),
                        )
                      : Container(
                          width: mWidth,
                          height: mHeight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/star_sky_bg.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          key: ValueKey<int>(2),
                        ),
                )),
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
                            controller.playAudio("frog.mp3");
                            controller.increment(1);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(1)
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
                            controller.playAudio("gecko.mp3");
                            controller.increment(2);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(2)
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
                            controller.playAudio("cricket-sound-113945.mp3");
                            controller.increment(3);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(3)
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
                            controller.playAudio("night-ambience.mp3");
                            controller.increment(4);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(4)
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
                            controller.playAudio("night-woods.mp3");
                            controller.increment(5);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(5)
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
                            controller.playAudio("campfire.mp3");
                            controller.increment(6);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(6)
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

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white // Warna garis
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    // Titik awal dan akhir garis
    Offset startPoint = Offset(0, size.height / 2);
    Offset endPoint = Offset(size.width, size.height / 2);

    // Menggambar garis dari titik awal ke titik akhir
    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
