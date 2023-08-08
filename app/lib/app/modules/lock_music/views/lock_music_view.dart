import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lock_music_controller.dart';

class LockMusicView extends GetView<LockMusicController> {
  const LockMusicView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LockMusicView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LockMusicView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
