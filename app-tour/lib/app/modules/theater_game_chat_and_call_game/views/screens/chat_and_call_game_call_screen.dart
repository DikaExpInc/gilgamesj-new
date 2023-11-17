import 'package:gilgamesj_tour/app/modules/theater_game_chat_and_call_game/views/widgets/countdown_timer_widget.dart';
import 'package:gilgamesj_tour/app/modules/theater_game_chat_and_call_game/controllers/theater_game_chat_and_call_game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatAndCallGameCallScreen
    extends GetView<TheaterGameChatAndCallGameController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Obx(
      () => controller.isCall.value
          ? controller.isGlitch.value
              ? Scaffold(
                  body: Container(
                    width: mWidth,
                    height: mHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/gif/ishtar-glitch.gif"),
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
                        image: AssetImage("assets/images/background2.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: mWidth / 4,
                              height: mWidth / 4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/ishtar-profile.png",
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Text(
                              "Ishtar",
                              style: TextStyle(
                                fontFamily: 'Abel',
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            CountdownTimerWidget(),
                          ],
                        ),
                        InkWell(
                          onTap: () => {controller.dissCallPhone()},
                          child: Image.asset(
                            "assets/images/phone_discall.png",
                            width: 70,
                            height: 70,
                          ),
                        )
                      ],
                    ),
                  ),
                )
          : Scaffold(
              body: Container(
                width: mWidth,
                height: mHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/ishtar_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Inkomend gesprek:\nIshtar",
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => {controller.callPhone()},
                        child: Image.asset(
                          "assets/images/phone_call.png",
                          width: 70,
                          height: 70,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
