import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_chat_game_done_controller.dart';

class MiniGameChatGameDoneView extends GetView<MiniGameChatGameDoneController> {
  const MiniGameChatGameDoneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniGameChatGameDoneView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MiniGameChatGameDoneView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
