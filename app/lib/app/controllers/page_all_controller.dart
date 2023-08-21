import 'dart:async';

import 'package:app/app/data/browser_model.dart';
import 'package:app/app/data/camera_model.dart';
import 'package:app/app/data/chat_detail_model.dart';
import 'package:app/app/data/chat_model.dart';
import 'package:app/app/data/contact_model.dart';
import 'package:app/app/data/gallery_photo_model.dart';
import 'package:app/app/data/gallery_video_model.dart';
import 'package:app/app/data/map_model.dart';
import 'package:app/app/data/phone_model.dart';
import 'package:app/app/data/setting_model.dart';
import 'package:app/app/data/social_media_comment.dart';
import 'package:app/app/data/social_media_model.dart';
import 'package:app/app/data/task_model.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/services/setting_service.dart';
import 'package:app/app/widgets/dialog/bonus_dialog.dart';
import 'package:app/app/widgets/dialog/bonus_skip_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PageAllController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxInt lengthNow = 0.obs;
  TaskListModel? tasks;
  BrowserListModel? browsers;
  CameraListModel? cameras;
  ChatListModel? chats;
  ChatDetailListModel? chatDetails;
  ContactListModel? contacts;
  GalleryPhotoListModel? galleryPhotos;
  GalleryVideoListModel? galleryVideos;
  MapListModel? maps;
  PhoneListModel? phones;
  SocialMediaListModel? socialMedias;
  SocialMediaCommentListModel? socialMediaComments;
  SettingModel? setting;
  RxString currentPage = "".obs;

  // timer
  RxString countdown = '00:00'.obs;
  RxInt countdownInMinutes = 0.obs;
  DateTime? startTime;
  Duration? duration;
  Duration? remainingTime;

  final Stream settingStream =
      Stream.periodic(const Duration(seconds: 2), (int count) {
    return count;
  });
  late StreamSubscription sub;

  void fetchDataFromApi() async {
    // Cek apakah data team name telah diisi
    String? teamName = GetStorage().read('teamName');
    if (teamName != null && teamName.isNotEmpty) {
      String? totalPlayer = GetStorage().read('totalPlayer');
      if (totalPlayer != null && totalPlayer.isNotEmpty) {
        update();
        SettingModel? settingModel = await SettingApi().getSetting();
        updateSetting(settingModel!);
        update();

        if (settingModel.statusCode == 200) {
          // Cek apakah halaman yang diterima sama dengan halaman saat ini
          if (setting!.page!.toString() != currentPage.toString()) {
            switch (setting!.page) {
              case "phone":
                changePage(1, setting!.page!);
                break;
              case "clap":
                changePage(2, setting!.page!);
                break;
              case "blank":
                changePage(3, setting!.page!);
                break;
              case "light":
                changePage(4, setting!.page!);
                break;
              case "notification":
                changePage(5, setting!.page!);
                break;
              case "group":
                changePage(6, setting!.page!);
                break;
              case "performance":
                changePage(7, setting!.page!);
                break;
              case "pre_game":
                changePage(8, setting!.page!);
                break;
              case "go_to_theater":
                changePage(9, setting!.page!);
                break;
              default:
                changePage(1, setting!.page!);
                break;
            }
          }
        } else if (settingModel.statusCode == 204) {
          print("Empty");
        } else if (settingModel.statusCode == 404) {
          update();
        } else if (settingModel.statusCode == 401) {
        } else {
          print("Something went wrong with status code 400");
        }
      }
    }
  }

  void changePage(int index, String paging) async {
    currentPage.value = paging;
    pageIndex.value = index;
    switch (index) {
      case 1:
        Get.offAllNamed(Routes.START);
        break;
      case 2:
        Get.offAllNamed(Routes.CLAP);
        break;
      case 3:
        Get.offAllNamed(Routes.BLANK);
        break;
      case 4:
        Get.offAllNamed(Routes.LIGHT);
        break;
      case 5:
        Get.offAllNamed(Routes.NOTIFICATION);
        break;
      case 6:
        Get.offAllNamed(Routes.GROUP);
        break;
      case 7:
        Get.offAllNamed(Routes.PERFORMANCE);
        break;
      case 8:
        Get.offAllNamed(Routes.INTRO);
        break;
      case 9:
        Get.offAllNamed(Routes.GO_THEATER);
        break;
      default:
        Get.offAllNamed(Routes.START);
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    sub = settingStream.listen((event) {
      fetchDataFromApi();
    });

    // membuat langganan
    // triggerStream.listen((event) {
    //   fetchDataFromApi();
    // });
  }

  void showBonusDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          // Cegah dialog ditutup dengan tombol "back"
          return false;
        },
        child: BonusDialog(),
      ),
      barrierDismissible: false,
    );
  }

  void showSkipBonusDialog() {
    Get.back();
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          // Cegah dialog ditutup dengan tombol "back"
          return false;
        },
        child: BonusSkipDialog(),
      ),
      barrierDismissible: false,
    );
  }

  void startCountdown(Duration remainingTime) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        remainingTime -= Duration(seconds: 1);
        String formattedCountdown =
            '${remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}';
        countdown.value = formattedCountdown;
        countdownInMinutes.value = remainingTime.inMinutes;
      } else {
        Get.offNamed(Routes.PERFORMANCE);
        timer.cancel(); // Stop the timer when countdown reaches 0 or negative
      }
    });
  }

  // Update Data

  void updateTask(TaskListModel newTasks) {
    tasks = newTasks;
  }

  void updateBrowser(BrowserListModel newBrowsers) {
    browsers = newBrowsers;
  }

  void updateCamera(CameraListModel newCameras) {
    cameras = newCameras;
  }

  void updateChat(ChatListModel newChats) {
    chats = newChats;
  }

  void updateChatDetails(ChatDetailListModel newChatDetails) {
    chatDetails = newChatDetails;
  }

  void updateContact(ContactListModel newContacts) {
    contacts = newContacts;
  }

  void updateGalleryPhoto(GalleryPhotoListModel newGalleryPhotos) {
    galleryPhotos = newGalleryPhotos;
  }

  void updateGalleryVideo(GalleryVideoListModel newGalleryVideos) {
    galleryVideos = newGalleryVideos;
  }

  void updateMap(MapListModel newMap) {
    maps = newMap;
  }

  void updatePhone(PhoneListModel newPhone) {
    phones = newPhone;
  }

  void updateSocialMedia(SocialMediaListModel newSocialMedia) {
    socialMedias = newSocialMedia;
  }

  void updateSocialMediaComment(
      SocialMediaCommentListModel newSocialMediaComment) {
    socialMediaComments = newSocialMediaComment;
  }

  void updateSetting(SettingModel newSetting) {
    setting = newSetting;
  }
}
