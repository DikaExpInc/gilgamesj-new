import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/app/modules/theater_game_choice_game/controllers/theater_game_choice_game_controller.dart';
import 'package:app/app/modules/theater_game_choice_game/views/screens/choice_game_character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: must_be_immutable
class ChoiceGameMessageScreen extends GetView<TheaterGameChoiceGameController> {
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
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          controller.rotatingParticle,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 60,
              ),
              Center(
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontFamily: 'Centrion',
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                          'Hey ${GetStorage().read('played_name_${GetStorage().read('played_number')}')}'),
                      TyperAnimatedText('wat moet Gilgamesj laten zien om'),
                      TyperAnimatedText('indruk maken op zijn vriend Enkidu?'),
                    ],
                    isRepeatingAnimation: false,
                    onFinished: () {
                      // Navigate to the next page here
                      controller.isFinished.value = true;
                    },
                  ),
                ),
              ),
              Obx(() {
                return controller.isFinished.value
                    ? InkWell(
                        onTap: () => {
                          controller.setWidget(ChoiceGameCharacterScreen()),
                          controller.startAutomaticChange(),
                        },
                        child: SvgPicture.asset(
                          "assets/icons/finger_real.svg",
                          width: 100,
                          height: 100,
                        ),
                      )
                    : SizedBox();
              }),
            ],
          ),
        ],
      ),
    ));
  }
}
