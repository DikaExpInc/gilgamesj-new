import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_rebus_controller.dart';

class TheaterGameRebusView extends GetView<TheaterGameRebusController> {
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
            image: AssetImage("assets/images/rebus-bg-game.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
