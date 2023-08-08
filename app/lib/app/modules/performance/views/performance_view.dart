import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/performance_controller.dart';

class PerformanceView extends GetView<PerformanceController> {
  const PerformanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PerformanceView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PerformanceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
