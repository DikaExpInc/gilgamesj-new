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
import 'package:perfect_volume_control/perfect_volume_control.dart';

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

  RxDouble currentVolume = 0.5.obs;

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
            String? player = GetStorage().read('player');
            String? status_seat_tablet =
                GetStorage().read('status_seat_tablet'); // row1, museum1
            String? position_tablet = GetStorage().read('position_tablet'); // left, right
            String? rij_tablet = GetStorage().read('rij_tablet'); // rij tablet

            print(setting!.control);
            switch (setting!.control) {
              case "volume-tablet-up":
                increaseVolume();
                break;
              case "volume-tablet-down":
                decreaseVolume();
                break;
              default:
                break;
            }
            switch (setting!.page) {
              case "lightning":
                if (setting!.player == "all") {
                  if (mode != "lightning") {
                    GetStorage().write('mode', "lightning");
                    Get.offAllNamed(Routes.LIGHTNING);
                  }
                }
                if (setting!.player == "all-museum1" &&
                    status_seat_tablet != "museum1") {
                  if (mode != "lightning") {
                    GetStorage().write('mode', "lightning");
                    Get.offAllNamed(Routes.LIGHTNING);
                  }
                }
                break;
              case "panic":
                if (setting!.player == "all") {
                  if (mode != "panic") {
                    GetStorage().write('mode', "panic");
                    Get.offAllNamed(Routes.BLANK);
                    Get.offAllNamed(Routes.BLANK);
                  }
                }
                break;
              case "pre-game":
                if (setting!.player == "all") {
                  if (mode != "pre-game" && mode != "item") {
                    GetStorage().write('mode', "pre-game");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.CHOICE_ROLE);
                  }
                }
                break;
              case "go-to-theater":
                if (setting!.player == "all") {
                  if (mode != "go-to-theater") {
                    GetStorage().write('mode', "go-to-theater");
                    Get.offAllNamed(Routes.TICKET);
                  }
                }
                if (setting!.player == "group-hemelstier" &&
                    status_seat_tablet == "hemelstier") {
                  if (mode != "go-to-theater") {
                    GetStorage().write('mode', "go-to-theater");
                    Get.offAllNamed(Routes.GO_THEATER);
                  }
                }
                break;
              case "go-to-museum1":
                if (setting!.player == "row1" && status_seat_tablet == "row1") {
                  if (mode != "go-to-museum1") {
                    GetStorage().write('mode', "go-to-museum1");
                    GetStorage().write('status_seat_tablet', "museum1");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Jullie zijn uitgekozen!",
                      "description":
                          "Sta op, ga naar het museum en zoek Enkidu."
                    });
                  }
                }
                if (setting!.player == "row2-left-side" &&
                    status_seat_tablet == "row2" &&
                    position_tablet == "left") {
                  if (mode != "go-to-museum1") {
                    GetStorage().write('mode', "go-to-museum1");
                    GetStorage().write('status_seat_tablet', "museum1");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title":
                          "Jullie hebben een geheime missie. Sta op en loop naar het museum",
                      "description":
                          "Geheime opdracht: Ga aan de linkerkant de zaal uit richting het museum. Neem je groepje mee!"
                    });
                  }
                }
                if (setting!.player == "group-ishtar" &&
                    status_seat_tablet == "ishtar") {
                  if (mode != "go-to-museum1") {
                    GetStorage().write('mode', "go-to-museum1");
                    GetStorage().write('status_seat_tablet', "museum1");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Verzamel je nu bij Ishtar",
                      "description":
                          "Ga met je groepje via de linkerkant naar het museum toe en wacht daar op Ishtar."
                    });
                  }
                }
                break;
              case "go-to-museum2":
                if (setting!.player == "row2-right-side" &&
                    status_seat_tablet == "row2" &&
                    position_tablet == "right") {
                  if (mode != "go-to-museum2") {
                    GetStorage().write('mode', "go-to-museum2");
                    GetStorage().write('status_seat_tablet', "museum2");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title":
                          "Jullie hebben een geheime missie. Sta op en loop naar het museum",
                      "description":
                          "Geheime opdracht: Ga aan de rechterkant de zaal uit richting het museum. Neem je groepje mee!"
                    });
                  }
                }
                if (setting!.player == "group-gilgamesj" &&
                    status_seat_tablet == "gilgamesj") {
                  if (mode != "go-to-museum2") {
                    GetStorage().write('mode', "go-to-museum2");
                    GetStorage().write('status_seat_tablet', "museum2");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Verzamel je nu bij Gilgamesj",
                      "description":
                          "Geheime opdracht: Ga aan de rechterkant de zaal uit richting het museum. Neem je groepje mee!"
                    });
                  }
                }
                break;
              case "game11-rebus":
                if (setting!.player == "all") {
                  if (mode != "game11-rebus") {
                    GetStorage().write('mode', "game11-rebus");
                    Get.offAllNamed(Routes.THEATER_GAME_REBUS);
                  }
                }
                break;
              case "give-the-tablet":
                if (setting!.player == "all") {
                  if (mode != "give-the-tablet") {
                    GetStorage().write('mode', "give-the-tablet");
                    Get.offAllNamed(Routes.GIVE_TABLET);
                    Get.offAllNamed(Routes.GIVE_TABLET);
                  }
                }
                if (setting!.player == "all+parent&mobility") {
                  if (mode != "give-the-tablet") {
                    GetStorage().write('mode', "give-the-tablet");
                    Get.offAllNamed(Routes.GIVE_TABLET);
                    Get.offAllNamed(Routes.GIVE_TABLET);
                  }
                }
                if (setting!.player == "all-museum1+2" &&
                    status_seat_tablet != "museum1" &&
                    status_seat_tablet != "museum2") {
                  if (mode != "give-the-tablet") {
                    GetStorage().write('mode', "give-the-tablet");
                    Get.offAllNamed(Routes.GIVE_TABLET);
                    Get.offAllNamed(Routes.GIVE_TABLET);
                  }
                }
                if (setting!.player == "museum1" &&
                    status_seat_tablet == "museum1") {
                  if (mode != "give-the-tablet") {
                    GetStorage().write('mode', "give-the-tablet");
                    Get.offAllNamed(Routes.GIVE_TABLET);
                    Get.offAllNamed(Routes.GIVE_TABLET);
                  }
                }
                if (setting!.player == "museum2" &&
                    status_seat_tablet == "museum2") {
                  if (mode != "give-the-tablet") {
                    GetStorage().write('mode', "give-the-tablet");
                    Get.offAllNamed(Routes.GIVE_TABLET);
                    Get.offAllNamed(Routes.GIVE_TABLET);
                  }
                }
                break;
              case "blank":
                if (setting!.player == "all") {
                  if (mode != "blank") {
                    GetStorage().write('mode', "blank");
                    Get.offAllNamed(Routes.BLANK);
                    Get.offAllNamed(Routes.BLANK);
                  }
                }
                if (setting!.player == "all-podium" &&
                    status_seat_tablet != "podium") {
                  if (mode != "blank") {
                    GetStorage().write('mode', "blank");
                    Get.offAllNamed(Routes.BLANK);
                    Get.offAllNamed(Routes.BLANK);
                  }
                }
                if (setting!.player == "all-museum1+2" &&
                    status_seat_tablet != "museum1" &&
                    status_seat_tablet != "museum2") {
                  if (mode != "blank") {
                    GetStorage().write('mode', "blank");
                    Get.offAllNamed(Routes.BLANK);
                    Get.offAllNamed(Routes.BLANK);
                  }
                }
                if (setting!.player == "museum1" &&
                    status_seat_tablet == "museum1") {
                  if (mode != "blank") {
                    GetStorage().write('mode', "blank");
                    Get.offAllNamed(Routes.BLANK);
                    Get.offAllNamed(Routes.BLANK);
                  }
                }
                if (setting!.player == "museum2" &&
                    status_seat_tablet == "museum2") {
                  if (mode != "blank") {
                    GetStorage().write('mode', "blank");
                    Get.offAllNamed(Routes.BLANK);
                    Get.offAllNamed(Routes.BLANK);
                  }
                }
                break;
              case "game1-shake":
                if (setting!.player == "all") {
                  if (mode != "game1-shake") {
                    GetStorage().write('mode', "game1-shake");
                    Get.offAllNamed(Routes.THEATER_GAME_SHAKE_GAME);
                  }
                }
                break;
              case "game8-light":
                if (setting!.player == "all") {
                  if (mode != "game8-light") {
                    GetStorage().write('mode', "game8-light");
                    Get.offAllNamed(Routes.THEATER_GAME_LIGHTNING_GAME_CUSTOM);
                  }
                }
                break;
              case "game2-gilgamesj":
                if (setting!.player == "all") {
                  if (mode != "game2-gilgamesj") {
                    GetStorage().write('mode', "game2-gilgamesj");
                    Get.offAllNamed(Routes.THEATER_GAME_LIGHTNING_GAME);
                  }
                }
                break;
              case "game5-choice-underwear":
                if (setting!.player == "all") {
                  if (mode != "game5-choice-underwear") {
                    GetStorage().write('mode', "game5-choice-underwear");
                    Get.offAllNamed(Routes.THEATER_GAME_CHOICE_GAME,
                        arguments: {"game": "underwear"});
                  }
                }
                break;
              case "chat-find-humbaba":
                if (setting!.player == "museum1" &&
                    status_seat_tablet == "museum1") {
                  if (mode != "chat-find-humbaba") {
                    GetStorage().write('mode', "chat-find-humbaba");
                    Get.offAllNamed(Routes.THEATER_GAME_CHAT_GAME,
                        arguments: {'game': 'find_humbaba', 'name': 'Humbaba'});
                  }
                }
                break;
              case "chat-find-spear":
                if (setting!.player == "museum2" &&
                    status_seat_tablet == "museum2") {
                  if (mode != "chat-find-spear") {
                    GetStorage().write('mode', "chat-find-spear");
                    Get.offAllNamed(Routes.THEATER_GAME_CHAT_GAME,
                        arguments: {'game': 'find_spear', 'name': 'Spear'});
                  }
                }
                break;
              case "star-game":
                if (setting!.player == "all-museum1+2" &&
                    status_seat_tablet != "museum1" &&
                    status_seat_tablet != "museum2") {
                  if (mode != "star-game") {
                    GetStorage().write('mode', "star-game");
                    Get.offAllNamed(Routes.THEATER_GAME_STAR_GAME);
                  }
                }
                break;
              case "game4-humbaba":
                if (setting!.player == "all-museum1+2" &&
                    status_seat_tablet != "museum1" &&
                    status_seat_tablet != "museum2") {
                  if (mode != "game4-humbaba") {
                    GetStorage().write('mode', "game4-humbaba");
                    Get.offAllNamed(Routes.THEATER_GAME_HUMBABA);
                  }
                }
                break;
              case "show-humbaba":
                if (setting!.player == "museum1" &&
                    status_seat_tablet == "museum1") {
                  if (mode != "show-humbaba") {
                    GetStorage().write('mode', "show-humbaba");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Humbaba tonen",
                      "description": "Neem Humbaba mee de zaal in"
                    });
                  }
                }
                break;
              case "give-spear":
                if (setting!.player == "museum2" &&
                    status_seat_tablet == "museum2") {
                  if (mode != "give-spear") {
                    GetStorage().write('mode', "give-spear");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Geef de speer aan Gilgamesj",
                      "description": ""
                    });
                  }
                }
                break;
              case "ishtar-calling":
                if (setting!.player == "random-row5" &&
                    status_seat_tablet == "row2" &&
                    rij_tablet == "3") {
                  if (mode != "ishtar-calling") {
                    GetStorage().write('mode', "ishtar-calling");
                    Get.offAllNamed(Routes.THEATER_GAME_CHAT_AND_CALL_GAME);
                  }
                }
                break;
              case "game7-chat-hemelstier":
                if (setting!.player == "all") {
                  if (mode != "game7-chat-hemelstier") {
                    GetStorage().write('mode', "game7-chat-hemelstier");
                    Get.offAllNamed(Routes.THEATER_GAME_CONTACT_CHAT);
                  }
                }
                break;
              case "choose-your-character":
                if (setting!.player == "all+parent") {
                  if (mode != "choose-your-character") {
                    GetStorage().write('mode', "choose-your-character");
                    Get.offAllNamed(Routes.THEATER_GAME_CHOOSE_YOUR_CHARACTER);
                  }
                }
                break;
              case "game10-die-tablet":
                if (setting!.player == "all") {
                  if (mode != "game10-die-tablet") {
                    GetStorage().write('mode', "game10-die-tablet");
                    Get.offAllNamed(Routes.THEATER_GAME_TABLET_DIES);
                  }
                }
                break;
              case "give-tablet-back":
                if (setting!.player == "all") {
                  if (mode != "give-tablet-back") {
                    GetStorage().write('mode', "give-tablet-back");
                    // Get.offAllNamed(Routes.BRING_TABLET_BACK);
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Tablet Terugbrengen",
                      "description":
                          "Neem de tablet mee en geef hem aan een medewerker"
                    });
                  }
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

  void increaseVolume() {
    currentVolume.value += 0.1;
    _updateSystemVolume(currentVolume.value);
  }

  void decreaseVolume() {
    currentVolume.value -= 0.1;
    _updateSystemVolume(currentVolume.value);
  }

  // Fungsi untuk memperbarui volume sistem
  Future<void> _updateSystemVolume(double volume) async {
    try {
      if (volume <= 1.0 && volume >= 0.0) {
        PerfectVolumeControl.setVolume(volume);
      }
    } catch (e) {
      print('Gagal mengubah volume: $e');
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
        Get.offAndToNamed(Routes.CHOICE_ROLE);
      }
    }
  }
}
