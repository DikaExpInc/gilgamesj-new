import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_choice_game_winner_controller.dart';

class TheaterGameChoiceGameWinnerView
    extends GetView<TheaterGameChoiceGameWinnerController> {
  const TheaterGameChoiceGameWinnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheaterGameChoiceGameWinnerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TheaterGameChoiceGameWinnerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
