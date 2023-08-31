import 'package:app/app/modules/pre_game_start/views/widgets/glitch_text_animation.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_start_controller.dart';

class PreGameStartView extends GetView<PreGameStartController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: InkWell(
      onTap: () => Get.toNamed(Routes.PRE_GAME_MENU),
      child: Container(
        width: mWidth,
        height: mHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.srcOver),
            image: AssetImage("assets/images/background3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GlitchTextAnimation(),
        ),
      ),
    ));
  }
}
