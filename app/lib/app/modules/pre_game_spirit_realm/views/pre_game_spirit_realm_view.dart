import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/pre_game_spirit_realm_controller.dart';

// ignore: must_be_immutable
class PreGameSpiritRealmView extends GetView<PreGameSpiritRealmController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(40),
      width: mWidth,
      height: mHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background4.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          controller.rotatingParticle,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(),
              Center(
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontFamily: 'Abel',
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                          'Richt de camera op de QR-code / AR-object.',
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
              Center(
                child: Obx(() {
                  return controller.isFinished.value
                      ? InkWell(
                          onTap: () => Get.toNamed(Routes.PRE_GAME_ITEMS),
                          child: Text(
                            'Doorgaan',
                            style: TextStyle(
                              fontFamily: 'Abel',
                              fontSize: 42,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : SizedBox();
                }),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
