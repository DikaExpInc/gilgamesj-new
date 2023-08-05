import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gilgamesj/app/modules/phone/views/tabs/contact_tab.dart';
import 'package:gilgamesj/app/modules/phone/views/tabs/phone_tab.dart';

class PhoneController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late RxString phoneNumber;
  final box = GetStorage();

  final List<GetView> myTabs = <GetView>[
    PhoneTab(),
    ContactTab(),
  ];

  late TabController tabController;
  int activeTabIndex = 1;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
    phoneNumber = "0".obs;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void updatePhoneNumber(String digit) {
    phoneNumber.value = phoneNumber.value + digit;
  }

  void deleteDigit() {
    if (phoneNumber.value.length > 1) {
      phoneNumber.value =
          phoneNumber.value.substring(0, phoneNumber.value.length - 1);
    } else {
      phoneNumber.value = "";
    }
  }

  void clearDigit() {
    phoneNumber.value = "";
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getStageById(
      String stageId) async {
    return await firestore.collection("stages").doc(stageId).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPhone() async* {
    String stageId = box.read("stage_id");

    DocumentSnapshot<Map<String, dynamic>> stageSnapshot =
        await getStageById(stageId);
    Map<String, dynamic> stageData = stageSnapshot.data()!;

    yield* firestore
        .collection("phones")
        .where(FieldPath.documentId, whereIn: stageData['data_game']["phone"])
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamContact() async* {
    String stageId = box.read("stage_id");

    DocumentSnapshot<Map<String, dynamic>> stageSnapshot =
        await getStageById(stageId);
    Map<String, dynamic> stageData = stageSnapshot.data()!;

    yield* firestore
        .collection("contacts")
        .where(FieldPath.documentId, whereIn: stageData['data_game']["contact"])
        .snapshots();
  }
}
