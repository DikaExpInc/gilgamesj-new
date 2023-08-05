import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:gilgamesj/app/widgets/toast/custom_toast.dart';

class MapsController extends GetxController {
  RxBool isBottomSheetVisible = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var tasks = RxList<Map<String, dynamic>>([]);
  var doneTasks = RxList<Map<String, dynamic>>([]);
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchData();
    fetchDoneTask();
  }

  void toggleBottomSheetVisibility() {
    isBottomSheetVisible.value = !isBottomSheetVisible.value;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getStageById(
      String stageId) async {
    return await firestore.collection("stages").doc(stageId).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLocation() async* {
    String stageId = box.read("stage_id");

    DocumentSnapshot<Map<String, dynamic>> stageSnapshot =
        await getStageById(stageId);
    Map<String, dynamic> stageData = stageSnapshot.data()!;

    List<String>? mapIds = stageData['data_game']["map"]?.cast<String>();
    if (mapIds == null || mapIds.isEmpty) {
      return;
    }

    yield* firestore
        .collection("maps")
        .where(FieldPath.documentId, whereIn: mapIds)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTask() {
    var taskQuery = firestore
        .collection("tasks")
        .where('stage_id', isEqualTo: box.read("stage_id"))
        .where('type', isEqualTo: 'maps')
        .snapshots();

    return taskQuery;
  }

  void fetchData() {
    streamTask().listen((snapshot) {
      tasks.value =
          snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamDoneTask() {
    String uid = auth.currentUser!.uid;

    var taskQuery = firestore
        .collection("team_name")
        .doc(uid)
        .collection("tasks")
        .snapshots();

    return taskQuery;
  }

  void fetchDoneTask() {
    streamDoneTask().listen((snapshot) {
      doneTasks.value = snapshot.docs.map((doc) => {'id': doc.id}).toList();
      tasks.removeWhere(
          (task) => doneTasks.any((doneTask) => doneTask['id'] == task['id']));
    });
  }

  Future<void> openTask(String task_id) async {
    isLoading.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      String uid = auth.currentUser!.uid;
      CollectionReference<Map<String, dynamic>> userChatCollection =
          await firestore.collection("team_name").doc(uid).collection("tasks");
      // Cek apakah task sudah diselesaikan
      bool taskCompleted = false;
      QuerySnapshot<Map<String, dynamic>> taskSnapshot =
          await userChatCollection.where("task_id", isEqualTo: task_id).get();

      if (taskSnapshot.docs.isNotEmpty) {
        taskCompleted = true;
      }

      if (!taskCompleted) {
        CustomToast.successToast('Success', 'Task successfully');

        await userChatCollection.doc(task_id).set({
          "task_id": task_id,
          "stage_id": box.read("stage_id"),
          "created_at": DateTime.now().toIso8601String(),
        });
      }

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'error : ${e.toString()}');
    }
  }
}
