import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_photo_controller.dart';

class PreGamePhotoView extends GetView<PreGamePhotoController> {
  const PreGamePhotoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PreGamePhotoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PreGamePhotoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
