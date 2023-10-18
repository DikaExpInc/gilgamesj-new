import 'package:app/app/modules/pre_game_guess/controllers/pre_game_guess_controller.dart';
import 'package:app/app/modules/pre_game_guess/views/widgets/guess_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GuessGameQuestionScreen extends GetView<PreGameGuessController> {
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
              Text(
                '${controller.questions[controller.currentIndex.value].question}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontFamily: 'Abel',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Obx(
                () => Image.asset(
                  '${controller.questions[controller.currentIndex.value].image}',
                  width: mWidth / 1.3,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'wat zou je doen als?',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => GuessWidget(
                      title:
                          "${controller.questions[controller.currentIndex.value].choice1}", // Cast setiap jawaban menjadi String
                      position: true, // Sesuaikan dengan posisi yang sesuai
                      press: () {
                        controller.goToNextQuestion();
                      },
                    ),
                  ),
                  Obx(
                    () => GuessWidget(
                      title:
                          "${controller.questions[controller.currentIndex.value].choice2}", // Cast setiap jawaban menjadi String
                      position: false, // Sesuaikan dengan posisi yang sesuai
                      press: () {
                        controller.goToNextQuestion();
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
