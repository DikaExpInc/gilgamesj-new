import 'package:app/app/modules/theater_game_chat_and_call_game/controllers/theater_game_chat_and_call_game_controller.dart';
import 'package:app/app/modules/theater_game_chat_and_call_game/views/widgets/countdown_timer_widget.dart';
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
      () => Scaffold(
        body: controller.isIdleTimerRunning.value
            ? Container(
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
                        onTap: () => {
                          controller.callPhone(),
                        },
                        child: Image.asset(
                          "assets/images/phone_call.png",
                          width: 70,
                          height: 70,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                color: Colors.black,
              ),
      ),
    );
  }
}
