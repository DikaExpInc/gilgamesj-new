import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:get/get_rx/get_rx.dart';

class PreGameMusicTheaterGameController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _controllerDisk;
  final AudioCache audioCache =
      AudioCache(prefix: 'assets/audios/pregames/theater_music/');
  AudioPlayer audioPlayer = AudioPlayer();
  late Timer audioTimer;
  Rx<String> audioFile = Rx<String>("");
  RxBool showButtons = true.obs;

  Rx<int> currentTimer = Rx<int>(0);
  RxInt selectedImageIndex = RxInt(-1);
  int tickCount = 0;

  RxString audio1 = RxString("");
  RxString audio2 = RxString("");
  RxString audio3 = RxString("");

  @override
  void onInit() {
    super.onInit();
    Vibration.vibrate(duration: 1000);

    // Atur timer dengan interval 13 detik
    const timerDuration = Duration(seconds: 1);
    audioTimer = Timer.periodic(timerDuration, (timer) async {
      // Tambah tickCount dan atur ulang ke 0 jika mencapai 13
      tickCount = (tickCount + 1) % 14;

      // Kirim nilai ke Rx variable
      currentTimer.value = tickCount;
      if (currentTimer.value == 0 && audioFile != "") {
        audioPlayer = await audioCache.play(audioFile.value);
      }
    });

    _controllerDisk = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();
  }

  // Method untuk memainkan audio
  Future<void> playAudio(String audioFileName) async {
    audioFile.value = audioFileName;
    print(audioFile.value);
  }

  @override
  void onClose() {
    // Hentikan timer saat controller dihapus
    audioTimer.cancel();
    _controllerDisk.dispose();
    super.onClose();
  }

  Widget rotatingDisk(String image) {
    return RotationTransition(
      turns: _controllerDisk,
      child: Stack(
        children: [
          Image.asset('assets/images/bg_player.png'),
          Positioned.fill(
            child: Center(
              child: Image.asset(image),
            ),
          ),
        ],
      ),
    );
  }
}
