import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class PreGameMusicGameController extends GetxController {
  //TODO: Implement PreGameMusicGameController

  final count = 0.obs;
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');

  playAudioSequenceFromLockCode() async {
    int lockCode = 1576;
    String lockCodeString = lockCode.toString();
    List<String> audioSequence = lockCodeString.split('').map((digit) {
      return 'tuts/$digit.mp3';
    }).toList();

    for (String audioFile in audioSequence) {
      await audioCache.play(audioFile);
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  @override
  void onInit() {
    super.onInit();
    playAudioSequenceFromLockCode();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
