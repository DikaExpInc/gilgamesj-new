import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final Map<String, dynamic> socialMediaData = Get.arguments;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  late Map<String, dynamic> stageData;

  // get data by Stage ID
  Future<DocumentSnapshot<Map<String, dynamic>>> getSocialMediaById(
      String stageId) async {
    return await firestore.collection("social_medias").doc(stageId).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamComment() async* {
    DocumentSnapshot<Map<String, dynamic>> stageSnapshot =
        await getSocialMediaById(socialMediaData['id']);
    stageData = stageSnapshot.data()!;

    yield* firestore
        .collection("social_medias")
        .doc(socialMediaData['id'])
        .collection('detail_comments')
        .snapshots();
  }
}
