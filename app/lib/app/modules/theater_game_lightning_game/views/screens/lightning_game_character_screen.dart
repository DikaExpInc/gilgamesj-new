import 'package:app/app/modules/theater_game_lightning_game/controllers/theater_game_lightning_game_controller.dart';
import 'package:app/app/modules/theater_game_lightning_game/views/screens/lightning_game_light_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class LightningGameCharacterScreen
    extends GetView<TheaterGameLightningGameController> {
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
                  duration: Duration(milliseconds: 100),
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
                  duration: Duration(milliseconds: 100),
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
              left: mWidth / 20,
              top: mHeight / 20,
              child: Obx(
                () => Text(
                  "Gilgamesj",
                  style: TextStyle(
                    fontFamily: 'Centrion',
                    fontSize: 42,
                    color: controller.characterSelect.value == "Gilgamesj"
                        ? Color(0xffFFD159)
                        : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              right: mWidth / 20,
              bottom: mHeight / 20,
              child: Obx(
                () => Text(
                  "Enkidu",
                  style: TextStyle(
                    fontFamily: 'Centrion',
                    fontSize: 42,
                    color: controller.characterSelect.value == "Enkidu"
                        ? Color(0xffFFD159)
                        : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              child: GestureDetector(
                onTapDown: (details) {
                  // Mendapatkan posisi ketika tap down terjadi.
                  final tapPosition = details.localPosition;
                  // Mengecek apakah titik yang diklik berada di dalam path segitiga.
                  if (isPointInsidePainterTop(tapPosition)) {
                    controller.characterSelect.value = "Gilgamesj";
                  }
                  if (isPointInsidePainterBottom(tapPosition)) {
                    controller.characterSelect.value = "Enkidu";
                  }
                  controller.audioCache.play('select.mp3');
                },
                child: CustomPaint(
                  painter:
                      MyPainterTop(), // Gantilah "MyPainter" dengan nama custom painter Anda.
                  size: Size(mWidth,
                      mHeight), // Sesuaikan ukuran sesuai kebutuhan Anda.
                ),
              ),
            ),
            Positioned(
              child: GestureDetector(
                onTapDown: (details) {
                  // Mendapatkan posisi ketika tap down terjadi.
                  final tapPosition = details.localPosition;
                  // Mengecek apakah titik yang diklik berada di dalam path segitiga.
                  if (isPointInsidePainterTop(tapPosition)) {
                    controller.characterSelect.value = "Gilgamesj";
                  }
                  if (isPointInsidePainterBottom(tapPosition)) {
                    controller.characterSelect.value = "Enkidu";
                  }
                  controller.audioCache.play('select.mp3');
                },
                child: CustomPaint(
                  painter:
                      MyPainterBottom(), // Gantilah "MyPainter" dengan nama custom painter Anda.
                  size: Size(mWidth,
                      mHeight), // Sesuaikan ukuran sesuai kebutuhan Anda.
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
                      child: Column(
                        children: [
                          Text(
                            'Wie kies jij?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 62,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'Druk om te kiezen',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Positioned(
                      top: mHeight / 2,
                      child: InkWell(
                          onTap: () => {
                                controller.audioCache.play('confirm.mp3'),
                                controller
                                    .setWidget(LightningGameLightScreen()),
                              },
                          child: Image.asset('assets/images/oke_button.png'))),
            ),
          ],
        ),
      ),
    );
  }

  bool isPointInsidePainterTop(Offset point) {
    final path = Path()
      ..moveTo(0, 0) // Pindahkan ke titik awal (0, 0)
      ..lineTo(0, mHeight - 60) // Garis ke titik (0, -20)
      ..lineTo(mWidth + 20, 0) // Garis ke titik (10, 0)
      ..close(); // Tutup path untuk membentuk segitiga

    return path.contains(point);
  }

  bool isPointInsidePainterBottom(Offset point) {
    final path = Path()
      ..moveTo(mWidth, mHeight)
      ..lineTo(-20, mHeight)
      ..lineTo(mWidth + 40, 0)
      ..close(); // Tutup path untuk membentuk segitiga

    return path.contains(point);
  }
}

class MyPainterTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0) // Pindahkan ke titik awal (0, 0)
      ..lineTo(0, size.height - 60) // Garis ke titik (0, -20)
      ..lineTo(size.width + 20, 0) // Garis ke titik (10, 0)
      ..close(); // Tutup path untuk membentuk segitiga

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Return true jika Anda ingin melakukan repaint saat ada perubahan.
  }
}

class MyPainterBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(-20, size.height)
      ..lineTo(size.width + 40, 0)
      ..close(); // Tutup path untuk membentuk segitiga

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Return true jika Anda ingin melakukan repaint saat ada perubahan.
  }
}
