import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StartController extends GetxController {
  final AudioCache audioCache = AudioCache(
    prefix: 'assets/audios/',
  );

  final box = GetStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    DocumentSnapshot<Map<String, dynamic>> stageSnapshot = await firestore
        .collection("stages")
        .where("order_number", isEqualTo: 1)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);

    if (stageSnapshot.exists) {
      box.write("background_url", stageSnapshot.data()!['backgroundUrl']);
      box.write("stage_id", stageSnapshot.id);
      box.write("stage_image", stageSnapshot.data()!['imageUrl']);
      box.write("stage_model", stageSnapshot.data()!['modelUrl:']);
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTeam() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("team_name").doc(uid).snapshots();
  }
}
