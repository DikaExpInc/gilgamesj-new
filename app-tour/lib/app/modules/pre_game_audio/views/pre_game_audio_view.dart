import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_audio_controller.dart';

// ignore: must_be_immutable
class PreGameAudioView extends GetView<PreGameAudioController> {
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
              controller.rotatingImage,
              InkWell(
                onTap: () => {
                  Get.offAllNamed(Routes.PRE_GAME_ITEMS),
                },
                child: Container(
                  width: mWidth / 4,
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal:
                          MediaQuery.of(context).size.width > 600 ? 50 : 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg_btn.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "BACK",
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width > 600 ? 16 : 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
