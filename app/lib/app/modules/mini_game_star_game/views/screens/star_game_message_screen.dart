import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/app/modules/mini_game_star_game/controllers/mini_game_star_game_controller.dart';
import 'package:app/app/modules/mini_game_star_game/views/screens/star_game_sky_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: must_be_immutable
class StarGameMessageScreen extends GetView<MiniGameStarGameController> {
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
                          'Sssssst ${GetStorage().read('played_name_${GetStorage().read('played_number')}')}'),
                      TyperAnimatedText('het is nacht. Maak geluid'),
                      TyperAnimatedText('maar doe het zacht.'),
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
                        onTap: () => controller.setWidget(StarGameSkyScreen()),
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
