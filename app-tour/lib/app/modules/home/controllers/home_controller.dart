import 'package:gilgamesj_tour/app/controllers/page_all_controller.dart';
import 'package:gilgamesj_tour/app/data/task_model.dart';
import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:gilgamesj_tour/app/services/task_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../widgets/loading.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final box = GetStorage();
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
  AudioPlayer? audioPlayer;
  RxBool isLoading = false.obs;
  final PageAllController pageAllController = Get.find<PageAllController>();

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    loadTasks();
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void logout() async {
    Get.offAllNamed(Routes.CREATE_TEAM);
  }

  loadTasks() async {
    update();
    showLoading();
    TaskListModel tasks = await TaskApi().loadTaskAPI(box.read('stage_id'));
    pageAllController.updateTask(tasks);
    update();
    stopLoading();
    if (tasks.statusCode == 200) {
    } else if (tasks.statusCode == 204) {
      print("Empty");
    } else if (tasks.statusCode == 404) {
      update();
    } else if (tasks.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
