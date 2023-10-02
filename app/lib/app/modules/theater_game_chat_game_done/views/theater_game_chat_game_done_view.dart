import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_chat_game_done_controller.dart';

class TheaterGameChatGameDoneView
    extends GetView<TheaterGameChatGameDoneController> {
  const TheaterGameChatGameDoneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheaterGameChatGameDoneView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TheaterGameChatGameDoneView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
