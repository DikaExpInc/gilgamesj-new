import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/clap_controller.dart';

class ClapView extends GetView<ClapController> {
  const ClapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClapView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ClapView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
