import 'package:gilgamesj_tour/app/data/gallery_video_model.dart';
import 'package:gilgamesj_tour/app/modules/gallery/views/tabs/photo_tab.dart';
import 'package:gilgamesj_tour/app/modules/gallery/views/tabs/video_tab.dart';
import 'package:gilgamesj_tour/app/services/gallery_video_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/page_all_controller.dart';
import '../../../data/gallery_photo_model.dart';
import '../../../services/gallery_photo_service.dart';
import '../../../widgets/loading.dart';

class GalleryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;

  final box = GetStorage();
  final PageAllController pageAllController = Get.find<PageAllController>();

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
    loadGalleryPhoto();
    loadGalleryVideo();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  loadGalleryPhoto() async {
    update();
    showLoading();
    GalleryPhotoListModel galleryPhoto =
        await GalleryPhotoApi().loadGalleryPhotoAPI();
    pageAllController.updateGalleryPhoto(galleryPhoto);
    update();
    stopLoading();
    if (galleryPhoto.statusCode == 200) {
    } else if (galleryPhoto.statusCode == 204) {
      print("Empty");
    } else if (galleryPhoto.statusCode == 404) {
      update();
    } else if (galleryPhoto.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  loadGalleryVideo() async {
    update();
    showLoading();
    GalleryVideoListModel galleryVideo =
        await GalleryVideoApi().loadGalleryVideoAPI();
    pageAllController.updateGalleryVideo(galleryVideo);
    update();
    stopLoading();
    if (galleryVideo.statusCode == 200) {
    } else if (galleryVideo.statusCode == 204) {
      print("Empty");
    } else if (galleryVideo.statusCode == 404) {
      update();
    } else if (galleryVideo.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
