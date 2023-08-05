import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:gilgamesj/app/widgets/toast/custom_toast.dart';

class CreateTeamController extends GetxController {
  @override
  onClose() {
    teamNameC.dispose();
  }

  final box = GetStorage();

  RxBool hasReconnect = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreatePegawai = false.obs;

  TextEditingController teamNameC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  onInit() {
    super.onInit();
    if (box.hasData("email") == true) {
      hasReconnect.value = true;
    } else {
      print("not logged in");
    }
  }

  Future<void> addTeamName() async {
    if (teamNameC.text.isNotEmpty) {
      isLoading.value = true;
      if (isLoadingCreatePegawai.isFalse) {
        await createTeamName();
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'you need to fill all form');
    }
  }

  createTeamName() async {
    isLoadingCreatePegawai.value = true;
    try {
      // get data stage
      DocumentSnapshot<Map<String, dynamic>> stageSnapshot = await firestore
          .collection("stages")
          .where("order_number", isEqualTo: 1)
          .get()
          .then((querySnapshot) => querySnapshot.docs.first);

      if (stageSnapshot.exists) {
        //get default password
        UserCredential employeeCredential =
            await auth.createUserWithEmailAndPassword(
          email: teamNameC.text.trim() + "@gilgamesj.com",
          password: "gilgamesj",
        );

        if (employeeCredential.user != null) {
          String stageId = stageSnapshot.id;
          box.write("email", teamNameC.text.trim() + "@gilgamesj.com");
          String uid = employeeCredential.user!.uid;
          DocumentReference team = firestore.collection("team_name").doc(uid);
          // Query untuk mendapatkan jumlah total pendaftaran tim
          QuerySnapshot<Map<String, dynamic>> registrationsSnapshot =
              await firestore.collection("team_name").get();

          int totalRegistrations = registrationsSnapshot.size;
          int group = totalRegistrations % 4 == 0
              ? totalRegistrations ~/ 4
              : (totalRegistrations ~/ 4) + 1;

          // Menghitung urutan kelompok berdasarkan jumlah total pendaftaran
          if (group > 4) {
            group = group % 4;
          }

          if (group == 0) {
            group = 4;
          }

          await team.set({
            "team_id": uid,
            "name": teamNameC.text,
            "created_at": DateTime.now().toIso8601String(),
            "stage_id": stageId,
            "group": group,
            "stage_time": stageSnapshot.data()!['timer'],
            "start_time": "",
          });

          box.write("background_url", stageSnapshot.data()!['backgroundUrl']);
          box.write("stage_id", stageSnapshot.id);
          box.write("stage_image", stageSnapshot.data()!['imageUrl']);
          box.write("stage_model", stageSnapshot.data()!['modelUrl']);
          box.write("stage_time", stageSnapshot.data()!['timer']);

          Get.back(); //close dialog
          CustomToast.successToast('Success', 'success creating team name');
          Get.toNamed(Routes.INTRODUCTION);
          isLoadingCreatePegawai.value = false;
        }
      }
    } on FirebaseAuthException catch (e) {
      isLoadingCreatePegawai.value = false;
      if (e.code == 'email-already-in-use') {
        CustomToast.errorToast('Error', 'Team name already exist');
      } else {
        CustomToast.errorToast('Error', 'error : ${e.code}');
      }
    } catch (e) {
      isLoadingCreatePegawai.value = false;
      CustomToast.errorToast('Error', 'error : ${e.toString()}');
    }
  }

  reconnect() async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: box.read("email"),
        password: "gilgamesj",
      );
      Get.toNamed(Routes.HOME);
    } catch (e) {
      CustomToast.errorToast('Error', 'error : ${e.toString()}');
    }
  }
}
