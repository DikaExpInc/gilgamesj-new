import 'dart:convert';

import 'package:app/app/modules/theater_game_chat_game/views/screens/chat_game_main_screen.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class TheaterGameChatGameController extends GetxController
    with GetTickerProviderStateMixin {
  Map<String, dynamic> arguments = Get.arguments;
  num getHeight() {
    return isDone.value ? 15 : 5;
  }

  final RxList<Map<String, dynamic>> chatDataAll = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> chatData = <Map<String, dynamic>>[].obs;
  int currentChatIndex = 0;
  RxBool isChoosingAnswer = false.obs;
  RxInt totalAnswers = 0.obs;

  late AnimationController _controller;
  late AnimationController _controllerParticle;
  RxBool isFinished = false.obs;
  RxBool isDone = false.obs;

  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
  AudioPlayer audioPlayer = AudioPlayer();
  final RxDouble _progressValue = 0.0.obs;
  double get progressValue => _progressValue.value;

  // onTap Loading
  final RxDouble tapValue = 0.0.obs;
  RxBool tapStatus = false.obs;

  @override
  void onClose() {
    _controller.dispose();
    _controllerParticle.dispose();

    super.onClose();
  }

  void startLoading() async {
    for (double i = 0.0; i <= 100.0; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      _progressValue.value = i;
    }
    _progressValue.value = 0;
    startLoading();
  }

  void startTapLoading() async {
    while (tapStatus.value) {
      await Future.delayed(Duration(milliseconds: 100));
      tapValue.value += 5;
      if (tapValue.value >= 100.0) {
        return nextStepAfterMessage();
      }
    }
  }

  void startTapFinish() async {
    while (tapStatus.value) {
      await Future.delayed(Duration(milliseconds: 100));
      tapValue.value += 5;
      if (tapValue.value >= 100.0) {
        return finishedGame();
      }
    }
  }

  void finishedGame() {
    Get.toNamed(Routes.THEATER_GAME_CHAT_GAME_DONE);
  }

  void nextStepAfterMessage() {
    loadNextChat();
    startLoading();
    fetchData();
    tapValue.value = 0;
    setWidget(ChatGameMainScreen());
  }

  void stopTapLoading() {
    tapStatus.value = false;
    tapValue.value = 0;
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

  //TODO: Implement TheaterGameLightningGameController
  // Buat sebuah variabel yang akan menampung widget yang akan dipanggil
  late Widget selectedWidget;

  // Buat sebuah metode untuk mengatur widget yang akan dipanggil
  void setWidget(Widget widget) {
    selectedWidget = widget;
    update(); // Memaksa pembaruan tampilan
  }

  @override
  void onInit() {
    // Di sini Anda dapat mengatur widget awal yang akan ditampilkan
    // setWidget(ChatGameMessageScreen());
    loadNextChat();
    startLoading();
    fetchData();
    tapValue.value = 0;
    setWidget(ChatGameMainScreen());
    Vibration.vibrate(duration: 1000);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();

    _controllerParticle = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();

    for (final chat in chatDataAll) {
      if (chat['tipe'] == 'ask') {
        final jawaban =
            chat['jawaban'] as List<dynamic>?; // Ubah tipe ke List<dynamic>
        if (jawaban != null) {
          totalAnswers += jawaban.length;
        }
      }
    }

    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      final jsonString = await loadJsonData();
      final jsonList = jsonDecode(jsonString);
      jsonList.forEach((chat) {
        final chatMap = chat as Map<String, dynamic>;
        chatMap['position'] =
            'left'; // Menambahkan nilai position dengan "left"
        chatDataAll.add(chatMap);
      });
      loadNextChat(); // Memulai chat dengan mengambil pesan pertama
    } catch (e) {
      print('Gagal memuat data JSON: $e');
    }
  }

  Future<String> loadJsonData() async {
    if (arguments['game'] == "wie_is_ut") {
      return await rootBundle.loadString('assets/json/wie_is_ut.json');
    } else if (arguments['game'] == "find_enkidu") {
      return await rootBundle.loadString('assets/json/find_enkidu.json');
    } else if (arguments['game'] == "find_humbaba") {
      return await rootBundle.loadString('assets/json/find_humbaba.json');
    } else if (arguments['game'] == "find_spear") {
      return await rootBundle.loadString('assets/json/find_spear.json');
    } else {
      return await rootBundle.loadString('assets/json/wie_is_ut.json');
    }
  }

  void loadNextChat() {
    if (currentChatIndex < chatDataAll.length) {
      final chat = chatDataAll[currentChatIndex];
      chatData.add(chat);
      if (chat['tipe'] == 'ask') {
        isChoosingAnswer.value = true; // Menampilkan pilihan jawaban
      } else {
        isChoosingAnswer.value = false; // Melanjutkan ke pesan berikutnya
        currentChatIndex++;
        loadNextChat();
      }
    }
  }

  void chooseAnswer(int answerIndex) {
    if (isChoosingAnswer.value) {
      final selectedAnswer = chatData.last['jawaban'][answerIndex];
      chatData.add({
        'tipe': 'answer',
        'position': 'right',
        'pesan': selectedAnswer,
      });
      print('Pemain memilih: $selectedAnswer');
      if (chatData.length > (chatDataAll.length + totalAnswers.value)) {
        isDone.value = true;
      }
      isChoosingAnswer.value = false;
      currentChatIndex++;
      loadNextChat();
    }
  }
}
