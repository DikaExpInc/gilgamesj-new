import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/start_controller.dart';

class StartView extends GetView<StartController> {
  const StartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StartView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StartView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
