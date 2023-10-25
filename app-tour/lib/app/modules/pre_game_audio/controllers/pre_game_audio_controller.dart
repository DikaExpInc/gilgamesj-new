import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PreGameAudioController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerParticle;
  final Map<String, dynamic> arguments = Get.arguments;
  final box = GetStorage();

  late AudioPlayer _audioPlayer;

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();

    _controllerParticle = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();

    _audioPlayer = AudioPlayer(); // Inisialisasi audio player

    _playAudio();
  }

  Future<void> _playAudio() async {
    final AudioCache audioCache = AudioCache(prefix: 'assets/audios/pregames/');

    if (arguments['id'] == 0) {
      box.write('pregame_item_0', true);
      _audioPlayer = await audioCache.loop('piano_laag1.wav');
    } else if (arguments['id'] == 1) {
      box.write('pregame_item_1', true);
      _audioPlayer = await audioCache.loop('snare_laag2.wav');
    } else if (arguments['id'] == 2) {
      box.write('pregame_item_2', true);
      _audioPlayer = await audioCache.loop('kick_laag3.wav');
    } else if (arguments['id'] == 3) {
      box.write('pregame_item_3', true);
      _audioPlayer = await audioCache.loop('808_laag4.wav');
    } else if (arguments['id'] == 5) {
      box.write('pregame_item_5', true);
      _audioPlayer = await audioCache.loop('hats_laag5.wav');
    } else if (arguments['id'] == 6) {
      box.write('pregame_item_6', true);
      _audioPlayer = await audioCache.loop('hats_laag5.wav');
    } else if (arguments['id'] == 7) {
      box.write('pregame_item_7', true);
      _audioPlayer = await audioCache.loop('hats_laag5.wav');
    } else if (arguments['id'] == 8) {
      box.write('pregame_item_8', true);
      _audioPlayer = await audioCache.loop('hats_laag5.wav');
    } else if (arguments['id'] == 9) {
      box.write('pregame_item_9', true);
      _audioPlayer = await audioCache.loop('hats_laag5.wav');
    } else {
      _audioPlayer = await audioCache.loop('hats_laag5.wav');
    }

    // Panggil loop untuk pemutaran berulang
    _audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  }

  @override
  void onClose() {
    _controller.dispose();
    _controllerParticle.dispose();
    // Hentikan pemutaran audio saat controller ditutup
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.onClose();
  }

  Widget get rotatingImage {
    return RotationTransition(
      turns: _controller,
      child: Image.asset('assets/images/center_of_god.png'),
    );
  }

  Widget get rotatingParticle {
    return RotationTransition(
      turns: _controllerParticle,
      child: Image.asset('assets/images/particle.png'),
    );
  }
}
