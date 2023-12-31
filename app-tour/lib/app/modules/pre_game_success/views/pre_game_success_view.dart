import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/pre_game_success_controller.dart';

// ignore: must_be_immutable
class PreGameSuccessView extends GetView<PreGameSuccessController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<PreGameSuccessController>(builder: (controller) {
      return Scaffold(
          body: Container(
        padding: EdgeInsets.all(40),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(child: Image.asset('assets/images/bonus_icon.png')),
                Center(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontFamily: 'Abel',
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText('Lekker bezig!\nSpel Voltooid!',
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
                            onTap: () => Get.toNamed(Routes.PRE_GAME_ITEMS_AR),
                            child: Container(
                              child: Text(
                                'Bevestigen',
                                style: TextStyle(
                                  fontFamily: 'Abel',
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
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
    });
  }
}
