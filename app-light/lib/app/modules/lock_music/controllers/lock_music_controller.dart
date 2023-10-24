import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LockMusicController extends GetxController {
  //TODO: Implement LockMusicController

  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
  final box = GetStorage();

  playAudioSequenceFromLockCode() async {
    if (box.read('tuts') != null) {
      int lockCode = box.read('tuts') ?? 0;
      String lockCodeString = lockCode.toString();
      List<String> audioSequence = lockCodeString.split('').map((digit) {
        return 'tuts/$digit.mp3';
      }).toList();

      for (String audioFile in audioSequence) {
        await audioCache.play(audioFile);
        await Future.delayed(Duration(milliseconds: 500));
      }
    }
  }
}
