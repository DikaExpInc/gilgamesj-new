import 'package:app/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final box = GetStorage();
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
  AudioPlayer? audioPlayer;

  @override
  void onInit() async {
    // updateClock();
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void logout() async {
    Get.offAllNamed(Routes.CREATE_TEAM);
  }
}
