import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_shake_game_controller.dart';

class PreGameShakeGameView extends GetView<PreGameShakeGameController> {
  const PreGameShakeGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PreGameShakeGameView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PreGameShakeGameView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
