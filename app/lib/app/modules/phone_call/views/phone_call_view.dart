import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/phone_call_controller.dart';

class PhoneCallView extends GetView<PhoneCallController> {
  const PhoneCallView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhoneCallView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PhoneCallView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
