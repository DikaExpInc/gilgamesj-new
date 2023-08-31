import 'package:app/app/modules/pre_game_menu/views/widgets/shaking_text_animation.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_menu_controller.dart';

class PreGameMenuView extends GetView<PreGameMenuController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Obx(
      () => controller.isGlitch.value
          ? Scaffold(
              body: Container(
                width: mWidth,
                height: mHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.srcOver),
                    image: AssetImage("assets/images/bg-glitch.gif"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : Scaffold(
              body: Container(
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(),
                      Center(
                          child:
                              Image.asset('assets/images/logo-pre-game.png')),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShakingTextAnimation(
                            url: Routes.PRE_GAME_TUTORIAL,
                            initialText: 'NEW GAME',
                            image: 'assets/gif/new-game.gif',
                            duration: 1,
                            width: 200,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          InkWell(
                            onTap: () async {
                              controller.isGlitch.value = true;
                              await Future.delayed(Duration(seconds: 1));
                              controller.isGlitch.value = false;
                            },
                            child: ShakingTextAnimation(
                              url: '',
                              initialText: 'CONTINUE',
                              image: 'assets/gif/continue.gif',
                              duration: 2,
                              width: 190,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ShakingTextAnimation(
                            url: Routes.PRE_GAME_CREDIT,
                            initialText: 'CREDITS',
                            image: 'assets/gif/credit.gif',
                            duration: 4,
                            width: 150,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
