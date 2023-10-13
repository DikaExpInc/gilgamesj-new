import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_guess_controller.dart';

class PreGameGuessView extends GetView<PreGameGuessController> {
  const PreGameGuessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PreGameGuessView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PreGameGuessView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
