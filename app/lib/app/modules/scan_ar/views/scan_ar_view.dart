import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/scan_ar_controller.dart';

class ScanArView extends GetView<ScanArController> {
  const ScanArView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScanArView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ScanArView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
