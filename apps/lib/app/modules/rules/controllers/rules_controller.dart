import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';

class RulesController extends GetxController {
  final box = GetStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Map<String, dynamic> rulesData = Get.arguments;

  Future<void> onNext() async {
    String uid = auth.currentUser!.uid;
    DocumentReference team = firestore.collection("team_name").doc(uid);

    print(rulesData['from']);

    if (rulesData['from'] == "start") {
      Get.back();
    } else {
      await team.update(
        {
          "start_time": DateTime.now().toIso8601String(),
        },
      );
      box.write("start_time", DateTime.now().toIso8601String());

      Get.toNamed(Routes.START);
    }
  }
}
