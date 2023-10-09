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
import 'package:app/app/data/user_model.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/services/auth_service.dart';
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
  final box = GetStorage();
  UserModel? user;

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
              case "start":
                if (mode != "start" && mode != "ticket") {
                  GetStorage().write('mode', "start");
                  Get.offAllNamed(Routes.CHOICE_ROLE);
                }
                break;
              case "phone":
                if (mode != "phone") {
                  GetStorage().write('mode', "phone");
                  if (GetStorage().read('stage_id') != null &&
                      GetStorage().read('stage_id').isNotEmpty) {
                    Get.offAllNamed(Routes.START);
                  } else {
                    Get.offAllNamed(Routes.INTRODUCTION);
                  }
                }
                break;
              case "clap":
                if (mode != "clap") {
                  GetStorage().write('mode', "clap");
                  Get.offAllNamed(Routes.CLAP);
                }
                break;
              case "blank":
                if (mode != "blank") {
                  GetStorage().write('mode', "blank");
                  Get.offAllNamed(Routes.BLANK);
                }
                break;
              case "light":
                if (mode != "light") {
                  GetStorage().write('mode', "light");
                  Get.offAllNamed(Routes.LIGHT);
                }
                break;
              case "notification":
                if (mode != "notification") {
                  GetStorage().write('mode', "notification");
                  Get.offAllNamed(Routes.NOTIFICATION);
                }
                break;
              case "group":
                if (mode != "group") {
                  GetStorage().write('mode', "group");
                  Get.offAllNamed(Routes.GROUP);
                }
                break;
              case "performance":
                if (mode != "performance") {
                  GetStorage().write('mode', "performance");
                  Get.offAllNamed(Routes.PERFORMANCE);
                }
                break;
              case "pre_game":
                if (mode != "pre_game" && mode != "item") {
                  GetStorage().write('mode', "pre_game");
                  Get.offAllNamed(Routes.PRE_GAME_ITEMS);
                }
                break;
              case "go_to_theater":
                if (mode != "go_to_theater") {
                  GetStorage().write('mode', "go_to_theater");
                  Get.offAllNamed(Routes.GO_THEATER);
                }
                break;
              case "intro":
                if (mode != "intro") {
                  GetStorage().write('mode', "intro");
                  Get.offAllNamed(Routes.PRE_GAME_SPLASH);
                }
                break;
              case "item":
                if (mode != "item") {
                  GetStorage().write('mode', "item");
                  Get.offAllNamed(Routes.PRE_GAME_ITEMS);
                }
                break;

              // Mini Game

              case "game_descibel":
                if (mode != "game_descibel") {
                  GetStorage().write('mode', "game_descibel");
                  Get.offAllNamed(Routes.MINI_GAME_DESCIBEL_GAME);
                }
                break;
              case "game_music":
                if (mode != "game_music") {
                  GetStorage().write('mode', "game_music");
                  Get.offAllNamed(Routes.MINI_GAME_MUSIC_GAME);
                }
                break;
              case "game_music_theater":
                if (mode != "game_music_theater") {
                  GetStorage().write('mode', "game_music_theater");
                  Get.offAllNamed(Routes.MINI_GAME_MUSIC_THEATER_GAME);
                }
                break;
              case "game_shake":
                if (mode != "game_shake") {
                  GetStorage().write('mode', "game_shake");
                  Get.offAllNamed(Routes.MINI_GAME_SHAKE_GAME);
                }
                break;

              // Theater Game

              case "game_light":
                if (mode != "game_light") {
                  GetStorage().write('mode', "game_light");
                  Get.offAllNamed(Routes.THEATER_GAME_LIGHTNING_GAME);
                }
                break;
              case "game_light_done":
                if (mode != "game_light_done") {
                  GetStorage().write('mode', "game_light_done");
                  Get.offAllNamed(Routes.THEATER_GAME_LIGHTNING_GAME_DONE);
                }
                break;
              case "game_star":
                if (mode != "game_star") {
                  GetStorage().write('mode', "game_star");
                  Get.offAllNamed(Routes.THEATER_GAME_STAR_GAME);
                }
                break;
              case "game_star_solving":
                if (mode != "game_star_solving") {
                  GetStorage().write('mode', "game_star_solving");
                  Get.offAllNamed(Routes.THEATER_GAME_STAR_GAME_SOLVING);
                }
                break;
              case "game_star_timer":
                if (mode != "game_star_timer") {
                  GetStorage().write('mode', "game_star_timer");
                  Get.offAllNamed(Routes.THEATER_GAME_STAR_TIMER_GAME);
                }
                break;
              case "game_star_done":
                if (mode != "game_star_done") {
                  GetStorage().write('mode', "game_star_done");
                  Get.offAllNamed(Routes.THEATER_GAME_STAR_GAME_DONE);
                }
                break;
              case "game_choice":
                if (mode != "game_choice") {
                  GetStorage().write('mode', "game_choice");
                  Get.offAllNamed(Routes.THEATER_GAME_CHOICE_GAME);
                }
                break;
              case "game_music_shake":
                if (mode != "game_music_shake") {
                  GetStorage().write('mode', "game_music_shake");
                  Get.offAllNamed(Routes.THEATER_GAME_SHAKE_GAME);
                }
                break;
              case "game_music_shake_done":
                if (mode != "game_music_shake_done") {
                  GetStorage().write('mode', "game_music_shake_done");
                  Get.offAllNamed(Routes.THEATER_GAME_SHAKE_GAME_DONE);
                }
                break;
              case "game_chat":
                if (mode != "game_chat") {
                  GetStorage().write('mode', "game_chat");
                  Get.offAllNamed(Routes.THEATER_GAME_CHAT_GAME);
                }
                break;
              case "game_chat_done":
                if (mode != "game_chat_done") {
                  GetStorage().write('mode', "game_chat_done");
                  Get.offAllNamed(Routes.THEATER_GAME_CHAT_GAME_DONE);
                }
                break;
              case "game_call_humbaba":
                if (mode != "game_call_humbaba") {
                  GetStorage().write('mode', "game_call_humbaba");
                  Get.offAllNamed(Routes.THEATER_GAME_CALL_HUMBABA_GAME);
                }
                break;
              case "game_call_humbaba_done":
                if (mode != "game_call_humbaba_done") {
                  GetStorage().write('mode', "game_call_humbaba_done");
                  Get.offAllNamed(Routes.THEATER_GAME_CALL_HUMBABA_GAME_DONE);
                }
                break;
              case "game_chat_and_call":
                if (mode != "game_chat_and_call") {
                  GetStorage().write('mode', "game_chat_and_call");
                  Get.offAllNamed(Routes.THEATER_GAME_CHAT_AND_CALL_GAME);
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

  autoLogin() async {
    update();
    if (box.hasData("token") == true) {
      user = await AuthApi().checkTokenApi(box.read("token"));
      if (user!.statusCode == 200) {
      } else if (user!.statusCode == 404) {
        update();
      } else {
        box.remove("token");
        box.remove("teamName");
        Get.offAndToNamed(Routes.PRE_GAME_START);
      }
    }
  }
}
