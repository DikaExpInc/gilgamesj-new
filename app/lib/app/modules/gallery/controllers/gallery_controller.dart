import 'package:app/app/modules/gallery/views/tabs/photo_tab.dart';
import 'package:app/app/modules/gallery/views/tabs/video_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GalleryController extends GetxController
    with GetSingleTickerProviderStateMixin {
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
    tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
