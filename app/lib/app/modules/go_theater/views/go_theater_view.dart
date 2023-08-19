import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/go_theater_controller.dart';

class GoTheaterView extends GetView<GoTheaterController> {
  const GoTheaterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoTheaterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GoTheaterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
