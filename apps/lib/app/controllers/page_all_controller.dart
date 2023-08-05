import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:gilgamesj/app/widgets/dialog/bonus_dialog.dart';
import 'package:gilgamesj/app/widgets/dialog/bonus_skip_dialog.dart';

class PageAllController extends GetxController {
  RxInt pageIndex = 0.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription<DocumentSnapshot>? settingsSubscription;
  StreamSubscription<DocumentSnapshot>? stagesSubscription;
  StreamSubscription<DocumentSnapshot>? teamNameSubscription;
  RxInt lengthNow = 0.obs;

  // timer
  RxString countdown = '00:00'.obs;
  RxInt countdownInMinutes = 0.obs;
  DateTime? startTime;
  Duration? duration;
  Duration? remainingTime;

  @override
  void onInit() {
    super.onInit();

    // Membuat langganan untuk perubahan pada dokumen settings
    settingsSubscription = firestore
        .collection("settings")
        .doc("S39qHZTYKj0scL9REJfR")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data();
        bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

        if (isLoggedIn) {
          switch (data?['page']) {
            case "group":
              changePage(2);
              break;
            case "clap":
              changePage(3);
              break;
            case "performance":
              changePage(4);
              break;
            default:
              changePage(1);
              break;
          }
        }
      }
    });

    firestore.collection("team_name").snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
        if (isLoggedIn) {
          String uid = auth.currentUser!.uid;
          stagesSubscription = firestore
              .collection("team_name")
              .doc(uid)
              .snapshots()
              .listen((snapshot) {
            if (snapshot.exists) {
              print("berubah");
              var dataTeam = snapshot.data();

              if (dataTeam?['start_time'] != "") {
                // mengatur waktu
                startTime = DateTime.parse(dataTeam?['start_time']);
                duration = Duration(minutes: dataTeam?['stage_time']);
                // Calculate the remaining time in seconds
                DateTime now = DateTime.now();
                remainingTime = startTime!.add(duration!).difference(now);
                // Update the countdown in the desired format (mm:ss)
                startCountdown(remainingTime!);
              }

              CollectionReference tasksCollection = firestore
                  .collection("team_name")
                  .doc(dataTeam?['team_id'])
                  .collection("tasks");

              // Mendengarkan perubahan pada koleksi "tasks"
              tasksCollection
                  .where('stage_id', isEqualTo: dataTeam?["stage_id"])
                  .snapshots()
                  .listen((snapshot) {
                lengthNow.value = snapshot.size;

                firestore
                    .collection("tasks")
                    .where('stage_id', isEqualTo: dataTeam?["stage_id"])
                    .snapshots()
                    .listen((snapshot) async {
                  if (snapshot.docs.isNotEmpty) {
                    // Menggunakan snapshot.docs untuk mengakses daftar dokumen
                    var documents = snapshot.docs;
                    if (lengthNow >= documents.length) {
                      CollectionReference<Map<String, dynamic>>
                          userChatCollection = await firestore
                              .collection("team_name")
                              .doc(uid)
                              .collection("stages");
                      await userChatCollection.doc(dataTeam?["stage_id"]).set({
                        "stage_id": dataTeam?["stage_id"],
                        "created_at": DateTime.now().toIso8601String(),
                      });
                      showBonusDialog();
                    }
                  }
                });
              });
            }
          });
        }
      }
    });
  }

  void showBonusDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          // Cegah dialog ditutup dengan tombol "back"
          return false;
        },
        child: BonusDialog(),
      ),
      barrierDismissible: false,
    );
  }

  void showSkipBonusDialog() {
    Get.back();
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          // Cegah dialog ditutup dengan tombol "back"
          return false;
        },
        child: BonusSkipDialog(),
      ),
      barrierDismissible: false,
    );
  }

  void changePage(int index) async {
    pageIndex.value = index;
    switch (index) {
      case 1:
        Get.offAllNamed(Routes.START);
        break;
      case 2:
        Get.offAllNamed(Routes.BLANK_SCREEN);
        break;
      case 3:
        Get.offAllNamed(Routes.CLAP_SCREEN);
        break;
      case 4:
        Get.offAllNamed(Routes.PERFORMANCE_SCREEN);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }

  void startCountdown(Duration remainingTime) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        remainingTime -= Duration(seconds: 1);
        String formattedCountdown =
            '${remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}';
        countdown.value = formattedCountdown;
        countdownInMinutes.value = remainingTime.inMinutes;
      } else {
        Get.offNamed(Routes.PERFORMANCE_SCREEN);
        timer.cancel(); // Stop the timer when countdown reaches 0 or negative
      }
    });
  }
}
