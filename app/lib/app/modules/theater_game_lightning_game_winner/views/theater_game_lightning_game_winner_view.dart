import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_lightning_game_winner_controller.dart';

class TheaterGameLightningGameWinnerView
    extends GetView<TheaterGameLightningGameWinnerController> {
  const TheaterGameLightningGameWinnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheaterGameLightningGameWinnerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TheaterGameLightningGameWinnerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
