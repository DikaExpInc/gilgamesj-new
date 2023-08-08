import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/social_media_controller.dart';

class SocialMediaView extends GetView<SocialMediaController> {
  const SocialMediaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SocialMediaView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SocialMediaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
