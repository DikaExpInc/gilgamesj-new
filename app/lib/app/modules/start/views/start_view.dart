import 'package:app/app/controllers/page_all_controller.dart';
import 'package:app/app/modules/start/controllers/start_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class StartView extends GetView<StartController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    Get.put(PageAllController());
    final PageAllController pageAllController = Get.find<PageAllController>();

    final List<int>? pattern =
        ModalRoute.of(context)!.settings.arguments as List<int>?;

    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: mWidth,
        height: mHeight,
        // color: colors[0],
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0), BlendMode.srcOver),
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: mHeight / 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Obx(() {
                        String countdown = pageAllController.countdown.value;
                        return Text(
                          "${countdown}",
                          style: TextStyle(
                            fontSize: mWidth > 600 ? 48 : 32,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 2,
                      indent: 5,
                      endIndent: 0,
                      width: 20,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, TEST",
                        style: TextStyle(
                          fontSize: mWidth > 600 ? 32 : 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Vrijdag, 31 maart",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dy < 0) {
                  // print("ini geser atas");
                  controller.audioCache.play('lock_code.mp3');
                  Get.toNamed(Routes.LOCK_MUSIC);
                }

                // if (details.delta.dy > 0) {
                //   print("ini geser bawah");
                // }
              },
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(mHeight /
                      (MediaQuery.of(context).size.width > 600 ? 8 : 16)),
                  child: Text(
                    "Swipe omhoog",
                    style: TextStyle(
                      fontSize: mWidth > 600 ? 24 : 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
