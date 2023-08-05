import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ClapController extends GetxController {
  RxInt valueClap = 0.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription<DocumentSnapshot>? settingsSubscription;

  @override
  void onInit() {
    super.onInit();
    // Membuat langganan untuk perubahan pada dokumen settings
    settingsSubscription = firestore
        .collection("settings")
        .doc("67tjgzl3kIytfIRKV0K5")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data();
        int newValueClap = data?['value_clap'] ?? 0;
        print("disini");
        print(data?['value_clap']);
        valueClap.value = newValueClap;
      }
    });
  }
}
