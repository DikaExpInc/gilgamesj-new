import 'package:gilgamesj_tour/app/modules/theater_game_choose_your_character/controllers/theater_game_choose_your_character_controller.dart';
import 'package:gilgamesj_tour/app/modules/theater_game_lightning_game/views/screens/lightning_game_light_screen.dart';
import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: must_be_immutable
class TheaterGameChooseCharacterScreenBackup
    extends GetView<TheaterGameChooseYourCharacterController> {
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
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.characterSelect.value = "gilgamesj";
                        controller.audioCache.play('select.mp3');
                      },
                      child: Obx(
                        () => AnimatedSwitcher(
                          duration: Duration(milliseconds: 100),
                          child: controller.characterSelect.value == "gilgamesj"
                              ? Image.asset(
                                  "assets/images/gilgamesj_select_active.png",
                                  key: ValueKey<int>(1),
                                  width: mWidth / 3,
                                )
                              : Image.asset(
                                  "assets/images/gilgamesj_select.png",
                                  key: ValueKey<int>(2),
                                  width: mWidth / 3,
                                ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.characterSelect.value = "ishtar";
                        controller.audioCache.play('select.mp3');
                      },
                      child: Obx(
                        () => AnimatedSwitcher(
                          duration: Duration(milliseconds: 100),
                          child: controller.characterSelect.value == "ishtar"
                              ? Image.asset(
                                  "assets/images/ishtar_select_active.png",
                                  key: ValueKey<int>(1),
                                  width: mWidth / 3,
                                )
                              : Image.asset(
                                  "assets/images/ishtar_select.png",
                                  key: ValueKey<int>(2),
                                  width: mWidth / 3,
                                ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.characterSelect.value = "hemelstier";
                        controller.audioCache.play('select.mp3');
                      },
                      child: Obx(
                        () => AnimatedSwitcher(
                          duration: Duration(milliseconds: 100),
                          child:
                              controller.characterSelect.value == "hemelstier"
                                  ? Image.asset(
                                      "assets/images/hemelsteir_select_active.png",
                                      key: ValueKey<int>(1),
                                      width: mWidth / 3,
                                    )
                                  : Image.asset(
                                      "assets/images/hemelsteir_select.png",
                                      key: ValueKey<int>(2),
                                      width: mWidth / 3,
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Obx(() {
            //   return Transform.rotate(
            //     angle: 35 *
            //         3.14159265359 /
            //         180, // Mengonversi sudut dari derajat ke radian
            //     child: AnimatedContainer(
            //       duration: Duration(milliseconds: 200),
            //       width: 20,
            //       height: controller.containerWidth.value,
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         color: Color(0xffD0891E),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Color(0xffD0891E),
            //             blurRadius: 10.0, // Jarak penyebaran efek glow
            //             spreadRadius: 5.0, // Jarak penyebaran efek glow
            //           ),
            //         ],
            //       ),
            //     ),
            //   );
            // }),
            Positioned(
              top: mHeight / 10,
              child: Column(
                children: [
                  Text(
                    'WIE KIES JIJ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Druk om te kiezen',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: Obx(
                      () => CircularProgressIndicator(
                        strokeWidth: 10,
                        color: Colors.white,
                        value: controller.containerWidth.value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.characterSelect == ""
                  ? Container()
                  : Positioned(
                      top: mHeight / 2,
                      child: InkWell(
                          onTap: () => {controller.onSubmit()},
                          child: Image.asset('assets/images/oke_button.png'))),
            ),
          ],
        ),
      ),
    );
  }
}
