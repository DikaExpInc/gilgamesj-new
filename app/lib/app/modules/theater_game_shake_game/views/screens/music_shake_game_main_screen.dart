import 'package:app/app/modules/theater_game_shake_game/controllers/theater_game_shake_game_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class MusicShakeGameMainScreen extends GetView<TheaterGameShakeGameController> {
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
            image: AssetImage("assets/images/music_shake_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: mHeight / 20,
              child: Text(
                "Schudden",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Centrion',
                  fontSize: 42,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
