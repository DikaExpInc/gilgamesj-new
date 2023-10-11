import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_contact_chat_controller.dart';

class TheaterGameContactChatView
    extends GetView<TheaterGameContactChatController> {
  const TheaterGameContactChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheaterGameContactChatView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TheaterGameContactChatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
