import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/theater_game_choose_your_character_done_controller.dart';

class TheaterGameChooseYourCharacterDoneView
    extends GetView<TheaterGameChooseYourCharacterDoneController> {
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
            image: AssetImage("assets/images/bg-resultaat-game2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            controller.arguments['selected'] == "ishtar"
                ? Column(
                    children: [
                      Image.asset(
                        'assets/images/ishtar_bg.png',
                        width: 400,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Ishtar',
                        style: TextStyle(
                          fontFamily: 'Centrion',
                          fontSize: 52,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                : Column(),
            controller.arguments['selected'] == "gilgamesj"
                ? Column(
                    children: [
                      Image.asset(
                        'assets/images/gilgamesj-bg.png',
                        width: 400,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Gilgamesj',
                        style: TextStyle(
                          fontFamily: 'Centrion',
                          fontSize: 52,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                : Column(),
            controller.arguments['selected'] == "hemelstier"
                ? Column(
                    children: [
                      Image.asset(
                        'assets/images/hemelstier-bg.png',
                        width: 400,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Hemelstier',
                        style: TextStyle(
                          fontFamily: 'Centrion',
                          fontSize: 52,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                : Column(),
          ],
        ),
      ),
    );
  }
}
