import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_choice_game_winner_controller.dart';

class TheaterGameChoiceGameWinnerView
    extends GetView<TheaterGameChoiceGameWinnerController> {
  late double mWidth;
  late double mHeight;
  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: mWidth,
          height: mHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0), BlendMode.srcOver),
              image: controller.indexWinner.value
                  ? AssetImage("assets/images/winner-ponny.png")
                  : AssetImage("assets/images/winner-sword.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
