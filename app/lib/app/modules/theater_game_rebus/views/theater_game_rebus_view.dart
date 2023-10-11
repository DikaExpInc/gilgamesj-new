import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_rebus_controller.dart';

class TheaterGameRebusView extends GetView<TheaterGameRebusController> {
  const TheaterGameRebusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheaterGameRebusView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TheaterGameRebusView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
