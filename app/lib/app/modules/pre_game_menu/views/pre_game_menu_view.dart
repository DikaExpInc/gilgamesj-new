import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_menu_controller.dart';

// ignore: must_be_immutable
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
                        Colors.black.withOpacity(0.0), BlendMode.srcOver),
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
                      // Center(
                      //     child:
                      //         Image.asset('assets/images/logo-pre-game.png')),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Schatten uit het',
                            style: TextStyle(
                              color: Color(0xff79684B),
                              fontSize: 68,
                            ),
                          ),
                          Text(
                            'Oosten',
                            style: TextStyle(
                              color: Color(0xff79684B),
                              fontSize: 128,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.CREATE_TEAM);
                            },
                            child: Text(
                              'START TOUR',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // InkWell(
                          //   onTap: () async {
                          //     final AudioCache audioCache =
                          //         AudioCache(prefix: 'assets/audios/');
                          //     audioCache.play('error-glitch.mp3');
                          //     controller.isGlitch.value = true;
                          //     await Future.delayed(Duration(seconds: 1));
                          //     controller.isGlitch.value = false;
                          //   },
                          //   child: Text(
                          //     'CONTINUE',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 38,
                          //       fontWeight: FontWeight.w800,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 40,
                          // ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.PRE_GAME_CREDIT);
                            },
                            child: Text(
                              'OVER',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
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
