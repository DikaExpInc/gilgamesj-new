import 'dart:async';

import 'package:app/app/widgets/dialog/descibel_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:noise_meter/noise_meter.dart';

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
    noiseMeter = NoiseMeter(onError);
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
