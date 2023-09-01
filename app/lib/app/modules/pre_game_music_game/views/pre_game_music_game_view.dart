import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_music_game_controller.dart';

class PreGameMusicGameView extends GetView<PreGameMusicGameController> {
  const PreGameMusicGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PreGameMusicGameView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PreGameMusicGameView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
