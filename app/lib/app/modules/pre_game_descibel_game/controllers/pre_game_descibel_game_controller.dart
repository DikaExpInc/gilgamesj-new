import 'dart:async';

import 'package:app/app/widgets/dialog/descibel_dialog.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:vibration/vibration.dart';

class PreGameDescibelGameController extends GetxController {
  //TODO: Implement PreGameDescibelGameController

  RxBool isRecording = false.obs;
  Rx<NoiseReading?> latestReading = Rx<NoiseReading?>(null);
  // NoiseReading? latestReading;
  StreamSubscription<NoiseReading>? noiseSubscription;
  NoiseMeter? noiseMeter;

  final LongPressGestureRecognizer longPressRecognizer =
      LongPressGestureRecognizer();

  @override
  void onInit() {
    super.onInit();
    Vibration.vibrate(duration: 1000);
    noiseMeter = NoiseMeter(onError);
    start(); // Start recording when long press begins
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    noiseSubscription?.cancel();
    super.onClose();
  }

  void onData(NoiseReading noiseReading) {
    latestReading.value = noiseReading;
    if (!isRecording.value) isRecording.value = true;
    if (latestReading.value!.maxDecibel >= 70) {
      showItemDialog(title: 'Waauw', description: 'Het is je gelukt !!');
      // final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
      // audioCache.play('spirit_realms.mp3');
      stop();
    }
  }

  void onError(Object error) {
    isRecording.value = false;
  }

  void start() {
    try {
      noiseSubscription = noiseMeter?.noise.listen(onData);
    } catch (err) {
      print(err);
    }
  }

  void stop() {
    try {
      noiseSubscription?.cancel();
      isRecording.value = false;
    } catch (err) {
      print(err);
    }
  }

  void showItemDialog({required String title, required String description}) {
    Get.dialog(
      DescibelDialog(
        title: title,
        description: description,
      ),
    );
  }
}
