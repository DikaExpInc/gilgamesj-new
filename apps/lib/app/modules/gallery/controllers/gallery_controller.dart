import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gilgamesj/app/modules/gallery/views/tabs/photo_tab.dart';
import 'package:gilgamesj/app/modules/gallery/views/tabs/video_tab.dart';
import 'package:gilgamesj/app/widgets/toast/custom_toast.dart';

class GalleryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var tasks = RxList<Map<String, dynamic>>([]);
  var doneTasks = RxList<Map<String, dynamic>>([]);
  RxBool isLoading = false.obs;

  final box = GetStorage();

  final List<GetView> myTabs = <GetView>[
    PhotoTab(),
    VideoTab(),
  ];

  late TabController tabController;
  int activeTabIndex = 1;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    fetchDoneTask();
    tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // get data by Stage ID
  Future<DocumentSnapshot<Map<String, dynamic>>> getStageById(
      String stageId) async {
    return await firestore.collection("stages").doc(stageId).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamGalleryPhoto() async* {
    String stageId = box.read("stage_id");

    DocumentSnapshot<Map<String, dynamic>> stageSnapshot =
        await getStageById(stageId);
    Map<String, dynamic> stageData = stageSnapshot.data()!;

    List<String>? photoIds =
        stageData['data_game']["gallery_photo"]?.cast<String>();
    if (photoIds == null || photoIds.isEmpty) {
      return;
    }

    yield* firestore
        .collection("gallery_photos")
        .where(FieldPath.documentId, whereIn: photoIds)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamGalleryVideo() async* {
    String stageId = box.read("stage_id");

    DocumentSnapshot<Map<String, dynamic>> stageSnapshot =
        await getStageById(stageId);
    Map<String, dynamic> stageData = stageSnapshot.data()!;

    yield* firestore
        .collection("gallery_videos")
        .where(FieldPath.documentId,
            whereIn: stageData['data_game']["gallery_video"])
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTask() {
    var taskQuery = firestore
        .collection("tasks")
        .where('stage_id', isEqualTo: box.read("stage_id"))
        .where('type', isEqualTo: 'gallery photo')
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
