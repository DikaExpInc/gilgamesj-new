import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_seat_controller.dart';

class ChangeSeatView extends GetView<ChangeSeatController> {
  const ChangeSeatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeSeatView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChangeSeatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
