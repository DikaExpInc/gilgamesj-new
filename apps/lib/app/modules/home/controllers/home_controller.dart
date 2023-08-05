import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  FirebaseAuth auth = FirebaseAuth.instance;
  final box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // RxString currentTime = ''.obs;
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
  AudioPlayer? audioPlayer;

  @override
  void onInit() async {
    // updateClock();
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    // await audioCache.load('backsound.mp3');
    // audioPlayer = await audioCache.loop('backsound.mp3');
  }

  @override
  void dispose() {
    super.dispose();
    // audioCache.fixedPlayer?.stop();
    // audioPlayer?.stop(); // Menghentikan audio saat memanggil dispose
    // audioPlayer?.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      // Aplikasi masuk ke status paused, hentikan musik
      // audioCache.fixedPlayer?.stop();
      // audioPlayer?.stop();
    } else if (state == AppLifecycleState.resumed) {
      // Aplikasi masuk ke status resumed, mulai ulang pemutaran musik
      // audioPlayer = await audioCache.loop('backsound.mp3');
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Lepaskan observer saat controller dihapus
    WidgetsBinding.instance.removeObserver(this);
    // Dispose audio player
    // audioPlayer?.dispose();
  }

  void logout() async {
    await auth.signOut();
    // await audioPlayer?.stop();
    // await audioCache.fixedPlayer?.stop();
    Get.offAllNamed(Routes.CREATE_TEAM);
  }

  // void updateClock() {
  //   DateTime now = DateTime.now();
  //   String formattedTime = DateFormat('HH:mm').format(now);
  //   currentTime.value = formattedTime;
  //   Future.delayed(
  //       Duration(minutes: 1), updateClock); // Memperbarui jam setiap menit
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTask() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("tasks")
        .where('stage_id', isEqualTo: box.read("stage_id"))
        .snapshots();
  }

  Future<bool> checkTaskExists(String taskId) async {
    String uid = auth.currentUser!.uid;

    DocumentSnapshot<Map<String, dynamic>> taskSnapshot = await firestore
        .collection("team_name")
        .doc(uid)
        .collection("tasks")
        .doc(taskId)
        .get();

    return taskSnapshot.exists;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamObjective() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("stages").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamObjectiveDone() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("team_name")
        .doc(uid)
        .collection("stages")
        .snapshots();
  }
}
