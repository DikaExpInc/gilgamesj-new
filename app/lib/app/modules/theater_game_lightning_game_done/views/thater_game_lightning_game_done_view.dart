import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../controllers/theater_game_lightning_game_done_controller.dart';

// ignore: must_be_immutable
class TheaterGameLightningGameDoneView
    extends GetView<TheaterGameLightningGameDoneController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<TheaterGameLightningGameDoneController>(
        builder: (controller) {
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'RESULTAAT',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Gilgamesj',
                            style: TextStyle(
                              fontFamily: 'Centrion',
                              fontSize: 42,
                              color: Colors.white,
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned(
                                child: Image.asset(
                                  'assets/images/gilgamesj-score.png',
                                  width: 400,
                                ),
                              ),
                              Positioned(
                                bottom: 50,
                                child: Text(
                                  '${controller.game2?.items![0].iV == null ? 0 : controller.game2?.items![0].iV} Spelers',
                                  style: TextStyle(
                                    fontFamily: 'Centrion',
                                    fontSize: 36,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Enkidu',
                            style: TextStyle(
                              fontFamily: 'Centrion',
                              fontSize: 42,
                              color: Colors.white,
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned(
                                child: Image.asset(
                                  'assets/images/enkidu-score.png',
                                  width: 400,
                                ),
                              ),
                              Positioned(
                                bottom: 50,
                                child: Text(
                                  '${controller.game2?.items![1].iV == null ? 0 : controller.game2?.items![1].iV} Spelers',
                                  style: TextStyle(
                                    fontFamily: 'Centrion',
                                    fontSize: 36,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox()
                ],
              )));
    });
  }
}
