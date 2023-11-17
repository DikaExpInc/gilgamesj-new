import 'package:gilgamesj_tour/app/modules/pre_game_guess/controllers/pre_game_guess_controller.dart';
import 'package:gilgamesj_tour/app/modules/pre_game_guess/views/screens/guess_game_question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GuessGameMainScreen extends GetView<PreGameGuessController> {
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
          image: AssetImage("assets/images/background3-black.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                '${controller.imageGame}',
                width: mWidth / 1.3,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                '${controller.titleGame}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontFamily: 'Abel',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Wat zou je doen als?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontFamily: 'Abel',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  controller.setWidget(GuessGameQuestionScreen());
                },
                child: Text(
                  'START',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Abel',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
