import 'package:app/app/modules/theater_game_chat_game/controllers/theater_game_chat_game_controller.dart';
import 'package:app/app/modules/theater_game_chat_game/views/widgets/answer_widget.dart';
import 'package:app/app/modules/theater_game_chat_game/views/widgets/chat_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ChatGameMainScreen extends GetView<TheaterGameChatGameController> {
  late double mWidth;
  late double mHeight;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    num getHeight = 2 > 2 ? 4 : 4;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: mWidth,
          height: mHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0), BlendMode.srcOver),
              image: AssetImage("assets/images/background3-black.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: mHeight / 15,
                  left: mWidth / 10,
                  right: mWidth / 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'test',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 9, // Ukuran lebar lingkaran
                                      height: 9, // Ukuran tinggi lingkaran
                                      decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // Mengatur bentuk menjadi lingkaran
                                        color: Colors
                                            .green, // Warna latar belakang lingkaran
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Online',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                'assets/images/isthar_profile_picture.png',
                              ),
                              radius: mWidth > 600 ? 40 : 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  ChatWidget(
                    chat: "Hello heroes, Here is your God Ishtar.",
                    type: "left",
                  ),
                  ChatWidget(
                    chat:
                        "that arogan King in trouble, I call you from other world and give second live for a reason,",
                    type: "left",
                  ),
                  ChatWidget(
                    chat: "Ahhh Helo ",
                    type: "right",
                  ),
                ],
              )),
              Container(
                width: mWidth,
                height: mHeight / getHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      AnswerWidget(title: 'test', position: true, press: () {}),
                      Center(
                        child: Obx(
                          () => CircularProgressIndicator(
                            color: Colors.white,
                            value: controller.progressValue / 100,
                          ),
                        ),
                      ),
                      AnswerWidget(
                          title: 'test', position: false, press: () {}),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
