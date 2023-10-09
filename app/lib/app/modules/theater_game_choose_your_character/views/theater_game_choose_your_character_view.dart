import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_choose_your_character_controller.dart';

class TheaterGameChooseYourCharacterView
    extends GetView<TheaterGameChooseYourCharacterController> {
  const TheaterGameChooseYourCharacterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheaterGameChooseYourCharacterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TheaterGameChooseYourCharacterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
