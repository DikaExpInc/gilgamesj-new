import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gilgamesj_tour/app/modules/theater_game_lightning_game_custom/controllers/theater_game_lightning_game_custom_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: must_be_immutable
class LightningGameCustomMessageScreen
    extends GetView<TheaterGameLightningGameCustomController> {
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
                          "Ik heb een geheime missie voor jou.\nOp het podium zie je een kleed, daar moet je\nop gaan staan, zonder je groepje. Druk\nmet je duim als je het aandurft. ",
                          textAlign: TextAlign.center),
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
                    ? GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onLongPressDown: (details) {
                          print('terprint');
                          controller.tapStatus.value = true;
                          controller.startTapLoading();
                        },
                        onLongPressUp: () {
                          print('terlepas');
                          controller.stopTapLoading();
                        },
                        onVerticalDragEnd: (details) => {
                          print('terlepas1'),
                          controller.stopTapLoading(),
                        },
                        onHorizontalDragEnd: (details) => {
                          print('terlepas2'),
                          controller.stopTapLoading(),
                        },
                        onTapUp: (details) => {
                          print('terlepas3'),
                          controller.stopTapLoading(),
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/finger_real.svg",
                              width: 100,
                              height: 100,
                            ),
                            Container(
                              width: 150,
                              height: 150,
                              child: Obx(
                                () => CircularProgressIndicator(
                                  color: Colors.white,
                                  value: controller.tapValue / 100,
                                ),
                              ),
                            ),
                          ],
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
