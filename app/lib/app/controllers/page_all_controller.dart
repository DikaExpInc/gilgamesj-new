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
import 'package:app/app/data/player_chat_model.dart';
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
  PlayerChatListModel? playerChat;
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
    // GetStorage().write('mode', "test");
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
            String? mode = GetStorage().read('mode');
            switch (setting!.page) {
              case "phone":
                if (mode == "phone") {
                  // GetStorage().write('mode', "phone");
                  if (GetStorage().read('stage_id') != null &&
                      GetStorage().read('stage_id').isNotEmpty) {
                    Get.offAllNamed(Routes.START);
                  } else {
                    Get.offAllNamed(Routes.INTRODUCTION);
                  }
                }
                break;
              case "clap":
                if (mode == "clap") {
                  Get.offAllNamed(Routes.CLAP);
                }
                break;
              case "blank":
                if (mode == "blank") {
                  Get.offAllNamed(Routes.BLANK);
                }
                break;
              case "light":
                if (mode == "light") {
                  Get.offAllNamed(Routes.LIGHT);
                }
                break;
              case "notification":
                if (mode == "notification") {
                  Get.offAllNamed(Routes.NOTIFICATION);
                }
                break;
              case "group":
                if (mode == "group") {
                  Get.offAllNamed(Routes.GROUP);
                }
                break;
              case "performance":
                if (mode == "performance") {
                  Get.offAllNamed(Routes.PERFORMANCE);
                }
                break;
              case "pre_game":
                if (mode == "pre_game") {
                  Get.offAllNamed(Routes.PRE_GAME_START);
                }
                break;
              case "go_to_theater":
                if (mode == "go_to_theater") {
                  Get.offAllNamed(Routes.GO_THEATER);
                }
                break;
              case "intro":
                if (mode == "intro") {
                  Get.offAllNamed(Routes.PRE_GAME_SPLASH);
                }
                break;
              case "item":
                if (mode == "item") {
                  Get.offAllNamed(Routes.PRE_GAME_ITEMS);
                }
                break;
              case "game_descibel":
                if (mode == "game_descibel") {
                  Get.offAllNamed(Routes.PRE_GAME_DESCIBEL_GAME);
                }
                break;
              case "game_music":
                if (mode != "game_music") {
                  GetStorage().write('mode', "game_music");
                  Get.offAllNamed(Routes.PRE_GAME_MUSIC_GAME);
                }
                break;
              default:
                if (mode != "intro") {
                  GetStorage().write('mode', "phone");
                  if (GetStorage().read('stage_id') != null &&
                      GetStorage().read('stage_id').isNotEmpty) {
                    Get.offAllNamed(Routes.START);
                  } else {
                    Get.offAllNamed(Routes.INTRODUCTION);
                  }
                }
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

  @override
  void onInit() {
    super.onInit();
    // membuat langganan
    sub = settingStream.listen((event) {
      fetchDataFromApi();
    });
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

  void updatePlayerChat(PlayerChatListModel newPlayerChat) {
    playerChat = newPlayerChat;
  }
}
