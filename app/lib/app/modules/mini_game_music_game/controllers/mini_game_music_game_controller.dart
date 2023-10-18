import 'package:app/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vibration/vibration.dart';

class MiniGameMusicGameController extends GetxController {
  final count = 0.obs;
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
  int lockCode = 0; // do sol si la
  final Map<String, dynamic> arguments = Get.arguments;

  RxString key_tuts = ''.obs;
  int maxDigits = 4;

  @override
  void onInit() {
    super.onInit();
    lockCode = arguments['lock_code'];
    playAudioSequenceFromLockCode();
    Vibration.vibrate(duration: 1000);
  }

  void increment(int inkWellIndex) {
    if (key_tuts.value.length < maxDigits - 1) {
      key_tuts.value = '${key_tuts.value}$inkWellIndex';
    } else {
      key_tuts.value = '${key_tuts.value}$inkWellIndex';
      String lockCodeString = lockCode.toString();
      print("key_tuts : ${key_tuts.value}");
      print("lockCode : ${lockCodeString}");
      if (lockCode.toString() == key_tuts.value) {
        int playedNumber = GetStorage().read('played_number') ?? 0;
        int totalPlayer = int.parse(GetStorage().read('totalPlayer'));
        if (playedNumber + 1 >= totalPlayer) {
          GetStorage().write('played_number', 0);
        } else {
          GetStorage().write('played_number', playedNumber + 1);
        }
        Get.offAllNamed(Routes.PRE_GAME_ITEMS);
      } else {
        audioCache.play('error-glitch.mp3');
      }
      reset();
    }
  }

  void reset() {
    key_tuts.value = '';
  }

  playAudioSequenceFromLockCode() async {
    String lockCodeString = lockCode.toString();
    List<String> audioSequence = lockCodeString.split('').map((digit) {
      return 'tuts/$digit.mp3';
    }).toList();

    print('putar dong');

    for (String audioFile in audioSequence) {
      await audioCache.play(audioFile);
      await Future.delayed(Duration(milliseconds: 500));
    }
  }
}
