import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import '../controllers/theater_game_choice_game_done_controller.dart';

// ignore: must_be_immutable
class TheaterGameChoiceGameDoneView
    extends GetView<TheaterGameChoiceGameDoneController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    double _calculateProgressValue(int index) {
      num itemValue = controller.game5?.items?[index].iV ?? 0.0;
      return (itemValue * (controller.totalPlayer.value - 1)) / 10;
    }

    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<TheaterGameChoiceGameDoneController>(
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
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Zijn zwaard',
                            style: TextStyle(
                              fontFamily: 'Centrion',
                              fontSize: 42,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Zijn little pony',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Centrion',
                              fontSize: 42,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned(
                                child: Image.asset(
                                  'assets/images/sword-score.png',
                                  width: 400,
                                ),
                              ),
                              Positioned(
                                bottom: 50,
                                child: Text(
                                  '${controller.game5?.items![1].iV == null ? 0 : controller.game5?.items![1].iV} Spelers',
                                  style: TextStyle(
                                    fontFamily: 'Centrion',
                                    fontSize: 36,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 380,
                                  height: 30,
                                  child: LiquidLinearProgressIndicator(
                                    value: _calculateProgressValue(1),
                                    valueColor: AlwaysStoppedAnimation(Colors
                                        .white), // Defaults to the current Theme's accentColor.
                                    backgroundColor: Colors
                                        .grey, // Defaults to the current Theme's backgroundColor.
                                    borderColor: Colors.white,
                                    borderWidth: 2.0,
                                    borderRadius: 11.0,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned(
                                child: Image.asset(
                                  'assets/images/underwear-score.png',
                                  width: 400,
                                ),
                              ),
                              Positioned(
                                bottom: 50,
                                child: Text(
                                  '${controller.game5?.items![0].iV == null ? 0 : controller.game5?.items![0].iV} Spelers',
                                  style: TextStyle(
                                    fontFamily: 'Centrion',
                                    fontSize: 36,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 380,
                                  height: 30,
                                  child: LiquidLinearProgressIndicator(
                                    value: _calculateProgressValue(0),
                                    valueColor: AlwaysStoppedAnimation(Colors
                                        .white), // Defaults to the current Theme's accentColor.
                                    backgroundColor: Colors
                                        .grey, // Defaults to the current Theme's backgroundColor.
                                    borderColor: Colors.white,
                                    borderWidth: 2.0,
                                    borderRadius: 11.0,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox()
                ],
              )));
    });
  }
}
