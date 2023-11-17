import 'dart:convert';

import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class TheaterGameContactChatDetailController extends GetxController {
  Map<String, dynamic> arguments = Get.arguments;

  final RxList<Map<String, dynamic>> chatDataAll = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> chatData = <Map<String, dynamic>>[].obs;
  int currentChatIndex = 0;
  RxBool isChoosingAnswer = false.obs;
  RxInt totalAnswers = 0.obs;

  RxBool isFinished = false.obs;
  RxBool isDone = false.obs;

  final RxDouble _progressValue = 0.0.obs;
  double get progressValue => _progressValue.value;

  // onTap Loading
  final RxDouble tapValue = 0.0.obs;
  RxBool tapStatus = false.obs;

  @override
  void onClose() {
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

  @override
  void onInit() {
    // Di sini Anda dapat mengatur widget awal yang akan ditampilkan
    // setWidget(ChatGameMessageScreen());
    loadNextChat();
    startLoading();
    fetchData();
    tapValue.value = 0;

    Vibration.vibrate(duration: 1000);

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
    if (arguments['game'] == "hemelstier") {
      return await rootBundle.loadString('assets/json/hemelstier.json');
    } else {
      return await rootBundle.loadString('assets/json/empty.json');
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
