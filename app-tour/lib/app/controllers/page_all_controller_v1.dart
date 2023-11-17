import 'dart:async';

import 'package:gilgamesj_tour/app/data/browser_model.dart';
import 'package:gilgamesj_tour/app/data/camera_model.dart';
import 'package:gilgamesj_tour/app/data/chat_detail_model.dart';
import 'package:gilgamesj_tour/app/data/chat_model.dart';
import 'package:gilgamesj_tour/app/data/contact_model.dart';
import 'package:gilgamesj_tour/app/data/gallery_photo_model.dart';
import 'package:gilgamesj_tour/app/data/gallery_video_model.dart';
import 'package:gilgamesj_tour/app/data/map_model.dart';
import 'package:gilgamesj_tour/app/data/phone_model.dart';
import 'package:gilgamesj_tour/app/data/player_chat_model.dart';
import 'package:gilgamesj_tour/app/data/setting_model.dart';
import 'package:gilgamesj_tour/app/data/social_media_comment.dart';
import 'package:gilgamesj_tour/app/data/social_media_model.dart';
import 'package:gilgamesj_tour/app/data/task_model.dart';
import 'package:gilgamesj_tour/app/data/user_model.dart';
import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:gilgamesj_tour/app/services/auth_service.dart';
import 'package:gilgamesj_tour/app/services/setting_service.dart';
import 'package:gilgamesj_tour/app/widgets/dialog/bonus_dialog.dart';
import 'package:gilgamesj_tour/app/widgets/dialog/bonus_skip_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PageAllControllerV1 extends GetxController {
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
            String? player = GetStorage().read('player');
            switch (setting!.page) {
              case "pre_game":
                if (setting!.player == "all") {
                  if (mode != "pre_game" && mode != "item") {
                    GetStorage().write('mode', "pre_game");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.CHOICE_ROLE);
                  }
                }
                break;
              case "go_to_theater":
                if (setting!.player == "all") {
                  if (mode != "go_to_theater" || player != "all") {
                    GetStorage().write('mode', "go_to_theater");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.GO_THEATER);
                  }
                }
                if (setting!.player == "hemelstier_group") {
                  if (mode != "go_to_theater") {
                    GetStorage().write('mode', "go_to_theater");
                    GetStorage().write('player', "hemelstier_group");
                    Get.offAllNamed(Routes.GO_THEATER);
                  }
                }
                break;
              case "tablet_holder":
                if (setting!.player == "all") {
                  if (mode != "tablet_holder") {
                    GetStorage().write('mode', "tablet_holder");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.TABLET_HOLDER);
                  }
                }
                break;
              case "blank":
                if (setting!.player == "all") {
                  if (mode != "blank") {
                    GetStorage().write('mode', "blank");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.BLANK);
                  }
                }
                break;
              case "go_to_museum_1":
                if (setting!.player == "left_side") {
                  if (mode != "go_to_museum_1") {
                    GetStorage().write('mode', "go_to_museum_1");
                    GetStorage().write('player', "left_side");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Jullie hebben een geheime missie!",
                      "description":
                          "Wees heel stil, en neem je groepje mee naar het tapijt op het podium."
                    });
                  }
                }
                if (setting!.player == "row3_left_side") {
                  if (mode != "go_to_museum_1") {
                    GetStorage().write('mode', "go_to_museum_1");
                    GetStorage().write('player', "row3_left_side");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Jullie hebben een geheime missie!",
                      "description":
                          "Wees heel stil, en neem je groepje zo snel als je kan aan de linkerkant van de zaal naar het museum. "
                    });
                  }
                }
                if (setting!.player == "row4-left-side") {
                  if (mode != "go_to_museum_1") {
                    GetStorage().write('mode', "go_to_museum_1");
                    GetStorage().write('player', "row4-left-side");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Geheime opdracht",
                      "description":
                          "Ga aan de linkerkant de zaal uit richting het museum. Neem je groepje mee!"
                    });
                  }
                }
                if (setting!.player == "isthar_group") {
                  if (mode != "go_to_museum_1") {
                    GetStorage().write('mode', "go_to_museum_1");
                    GetStorage().write('player', "isthar_group");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "",
                      "description":
                          "Ga met je groepje via de linkerkant naar het museum toe en wacht daar op Ishtar."
                    });
                  }
                }
                break;
              case "go_to_museum_2":
                if (setting!.player == "right_side") {
                  if (mode != "go_to_museum_2") {
                    GetStorage().write('mode', "go_to_museum_2");
                    GetStorage().write('player', "right_side");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Jullie hebben een geheime missie!",
                      "description":
                          "Wees heel stil, en neem je groepje zo snel als je kan aan de linkerkant van de zaal naar het museum. Druk je duim als je het gaat doen."
                    });
                  }
                }
                if (setting!.player == "row3_right_side") {
                  if (mode != "go_to_museum_2") {
                    GetStorage().write('mode', "go_to_museum_2");
                    GetStorage().write('player', "row3_right_side");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Jullie hebben een geheime missie! ",
                      "description":
                          "Wees heel stil, en neem je groepje zo snel als je kan aan de rechterkant van de zaal naar het museum. "
                    });
                  }
                }
                if (setting!.player == "row4-right-side") {
                  if (mode != "go_to_museum_2") {
                    GetStorage().write('mode', "go_to_museum_2");
                    GetStorage().write('player', "row4-right-side");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Geheime opdracht",
                      "description":
                          "Ga aan de rechterkant de zaal uit richting het museum. Neem je groepje mee!"
                    });
                  }
                }
                if (setting!.player == "gilgamesj_group") {
                  if (mode != "go_to_museum_2") {
                    GetStorage().write('mode', "go_to_museum_2");
                    GetStorage().write('player', "gilgamesj_group");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "",
                      "description":
                          "Ga met je groepje via de rechterkant naar het museum toe en wacht daar op Gilgamesj."
                    });
                  }
                }
                break;
              case "chat_game_wie_is_ut":
                if (setting!.player == "all") {
                  if (mode != "chat_game_wie_is_ut") {
                    GetStorage().write('mode', "chat_game_wie_is_ut");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.THEATER_GAME_CHAT_GAME,
                        arguments: {'game': 'wie_is_ut', 'name': 'Samas'});
                  }
                }
                break;
              case "chat_game_finding_enkidu":
                if (setting!.player == "museum1,museum2") {
                  if (mode != "chat_game_finding_enkidu") {
                    GetStorage().write('mode', "chat_game_finding_enkidu");
                    GetStorage().write('player', "museum1,museum2");
                    Get.offAllNamed(Routes.THEATER_GAME_CHAT_GAME,
                        arguments: {'game': 'find_enkidu', 'name': 'Enkidu'});
                  }
                }
                break;
              case "chat_game_find_humbaba":
                if (setting!.player == "museum1") {
                  if (mode != "chat_game_find_humbaba") {
                    GetStorage().write('mode', "chat_game_find_humbaba");
                    GetStorage().write('player', "museum1");
                    Get.offAllNamed(Routes.THEATER_GAME_CHAT_GAME,
                        arguments: {'game': 'find_humbaba', 'name': 'Humbaba'});
                  }
                }
                break;
              case "chat_game_find_spear":
                if (setting!.player == "museum2") {
                  if (mode != "chat_game_find_spear") {
                    GetStorage().write('mode', "chat_game_find_spear");
                    GetStorage().write('player', "museum2");
                    Get.offAllNamed(Routes.THEATER_GAME_CHAT_GAME,
                        arguments: {'game': 'find_spear', 'name': 'Spear'});
                  }
                }
                break;
              case "lead_the_audience":
                if (setting!.player == "museum1,museum2") {
                  if (mode != "lead_the_audience") {
                    GetStorage().write('mode', "lead_the_audience");
                    GetStorage().write('player', "museum1,museum2");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "",
                      "description":
                          "Ga snel terug naar je plek, en vertel het publiek wat ze moeten doen."
                    });
                  }
                }
                break;
              case "music_shake_game":
                if (setting!.player == "all") {
                  if (mode != "music_shake_game") {
                    GetStorage().write('mode', "music_shake_game");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.THEATER_GAME_SHAKE_GAME);
                  }
                }
                break;
              case "klaaglied_volk":
                if (setting!.player == "row1") {
                  if (mode != "klaaglied_volk") {
                    GetStorage().write('mode', "klaaglied_volk");
                    GetStorage().write('player', "row1");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "",
                      "description":
                          "Ga met je groepje  snel en stil op rij [seats] zitten. "
                    });
                  }
                }
                break;
              case "music_shake_game_done":
                if (setting!.player == "all") {
                  if (mode != "music_shake_game_done") {
                    GetStorage().write('mode', "music_shake_game_done");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.THEATER_GAME_SHAKE_GAME_DONE);
                  }
                }
                break;
              case "seats":
                if (setting!.player == "podium") {
                  if (mode != "seats") {
                    GetStorage().write('mode', "seats");
                    GetStorage().write('player', "podium");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "",
                      "description":
                          "Ga met je groepje  snel en stil op rij [seats] zitten. "
                    });
                  }
                }
                if (setting!.player == "museum1") {
                  if (mode != "seats") {
                    GetStorage().write('mode', "seats");
                    GetStorage().write('player', "museum1");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "",
                      "description":
                          "Ga met je groepje  snel en stil op rij [seats] zitten. "
                    });
                  }
                }
                if (setting!.player == "museum2") {
                  if (mode != "seats") {
                    GetStorage().write('mode', "seats");
                    GetStorage().write('player', "museum2");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "",
                      "description":
                          "Ga met je groepje  snel en stil op rij [seats] zitten. "
                    });
                  }
                }
                break;
              case "give_tablet_to":
                if (setting!.player == "1,17") {
                  if (mode != "give_tablet_to") {
                    GetStorage().write('mode', "give_tablet_to");
                    GetStorage().write('player', "1,17");
                    Get.offAllNamed(Routes.GIVE_TABLET);
                  }
                }
                break;
              case "light_game_gilgamesj":
                if (setting!.player == "side_seats") {
                  if (mode != "light_game_gilgamesj") {
                    GetStorage().write('mode', "light_game_gilgamesj");
                    GetStorage().write('player', "side_seats");
                    Get.offAllNamed(Routes.THEATER_GAME_LIGHTNING_GAME_CUSTOM,
                        arguments: {"name": "gilgamesj"});
                  }
                }
                break;
              case "light_game_enkidu":
                if (setting!.player == "7,8,9,10,11") {
                  if (mode != "light_game_enkidu") {
                    GetStorage().write('mode', "light_game_enkidu");
                    GetStorage().write('player', "7,8,9,10,11");
                    Get.offAllNamed(Routes.THEATER_GAME_LIGHTNING_GAME_CUSTOM,
                        arguments: {"name": "enkidu"});
                  }
                }
                break;
              case "light_game":
                if (setting!.player == "all_but") {
                  if (mode != "light_game") {
                    GetStorage().write('mode', "light_game");
                    GetStorage().write('player', "all_but");
                    Get.offAllNamed(Routes.THEATER_GAME_LIGHTNING_GAME);
                  }
                }
                break;
              case "seat_diagram":
                if (setting!.player == "podium") {
                  if (mode != "seat_diagram") {
                    GetStorage().write('mode', "seat_diagram");
                    GetStorage().write('player', "podium");
                    Get.offAllNamed(Routes.MOVEMENT_PAGE, arguments: {
                      "title": "Seat diagram",
                      "description": ""
                    });
                  }
                }
                break;
              case "choice_game_underwear":
                if (setting!.player == "all") {
                  if (mode != "choice_game_underwear") {
                    GetStorage().write('mode', "choice_game_underwear");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.THEATER_GAME_CHOICE_GAME,
                        arguments: {"game": "underwear"});
                  }
                }
                break;
              case "choice_game_sick":
                if (setting!.player == "museum1") {
                  if (mode != "choice_game_sick") {
                    GetStorage().write('mode', "choice_game_sick");
                    GetStorage().write('player', "museum1");
                    Get.offAllNamed(Routes.THEATER_GAME_CHOICE_GAME,
                        arguments: {"game": "sick"});
                  }
                }
                break;
              case "star_game":
                if (setting!.player == "all-row4") {
                  if (mode != "star_game") {
                    GetStorage().write('mode', "star_game");
                    GetStorage().write('player', "all-row4");
                    Get.offAllNamed(Routes.THEATER_GAME_STAR_GAME);
                  }
                }
                break;
              case "show_humbaba":
                if (setting!.player == "all-museum1-museum2") {
                  if (mode != "show_humbaba") {
                    GetStorage().write('mode', "show_humbaba");
                    GetStorage().write('player', "all-museum1-museum2");
                    Get.offAllNamed(Routes.THEATER_GAME_SHOW_HUMBABA);
                  }
                }
                break;
              case "calling_game_isthar":
                if (setting!.player == "row5-random") {
                  if (mode != "calling_game_isthar") {
                    GetStorage().write('mode', "calling_game_isthar");
                    GetStorage().write('player', "row5-random");
                    Get.offAllNamed(Routes.THEATER_GAME_CHAT_AND_CALL_GAME);
                  }
                }
                break;
              case "choose_your_character":
                if (setting!.player == "all") {
                  if (mode != "choose_your_character") {
                    GetStorage().write('mode', "choose_your_character");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.THEATER_GAME_CHOOSE_YOUR_CHARACTER);
                  }
                }
                break;
              case "tablet_dies":
                if (setting!.player == "all") {
                  if (mode != "tablet_dies") {
                    GetStorage().write('mode', "tablet_dies");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.THEATER_GAME_TABLET_DIES);
                  }
                }
                break;
              case "reviving_game":
                if (setting!.player == "all") {
                  if (mode != "reviving_game") {
                    GetStorage().write('mode', "reviving_game");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.THEATER_GAME_REVIVING);
                  }
                }
                break;
              case "bring_tablets_back":
                if (setting!.player == "all") {
                  if (mode != "bring_tablets_back") {
                    GetStorage().write('mode', "bring_tablets_back");
                    GetStorage().write('player', "all");
                    Get.offAllNamed(Routes.BRING_TABLET_BACK);
                  }
                }
                break;

              // Mini Game

              // case "game_descibel":
              //   if (mode != "game_descibel") {
              //     GetStorage().write('mode', "game_descibel");
              //     Get.offAllNamed(Routes.MINI_GAME_DESCIBEL_GAME);
              //   }
              //   break;
              // case "game_music":
              //   if (mode != "game_music") {
              //     GetStorage().write('mode', "game_music");
              //     Get.offAllNamed(Routes.MINI_GAME_MUSIC_GAME);
              //   }
              //   break;
              // case "game_music_theater":
              //   if (mode != "game_music_theater") {
              //     GetStorage().write('mode', "game_music_theater");
              //     Get.offAllNamed(Routes.MINI_GAME_MUSIC_THEATER_GAME);
              //   }
              //   break;
              // case "game_shake":
              //   if (mode != "game_shake") {
              //     GetStorage().write('mode', "game_shake");
              //     Get.offAllNamed(Routes.MINI_GAME_SHAKE_GAME);
              //   }
              //   break;

              // // Theater Game

              // case "game_light":
              //   if (mode != "game_light") {
              //     GetStorage().write('mode', "game_light");
              //     Get.offAllNamed(Routes.THEATER_GAME_LIGHTNING_GAME);
              //   }
              //   break;
              // case "game_light_done":
              //   if (mode != "game_light_done") {
              //     GetStorage().write('mode', "game_light_done");
              //     Get.offAllNamed(Routes.THEATER_GAME_LIGHTNING_GAME_DONE);
              //   }
              //   break;
              // case "game_star":
              //   if (mode != "game_star") {
              //     GetStorage().write('mode', "game_star");
              //     Get.offAllNamed(Routes.THEATER_GAME_STAR_GAME);
              //   }
              //   break;
              // case "game_star_solving":
              //   if (mode != "game_star_solving") {
              //     GetStorage().write('mode', "game_star_solving");
              //     Get.offAllNamed(Routes.THEATER_GAME_STAR_GAME_SOLVING);
              //   }
              //   break;
              // case "game_star_timer":
              //   if (mode != "game_star_timer") {
              //     GetStorage().write('mode', "game_star_timer");
              //     Get.offAllNamed(Routes.THEATER_GAME_STAR_TIMER_GAME);
              //   }
              //   break;
              // case "game_star_done":
              //   if (mode != "game_star_done") {
              //     GetStorage().write('mode', "game_star_done");
              //     Get.offAllNamed(Routes.THEATER_GAME_STAR_GAME_DONE);
              //   }
              //   break;
              // case "game_choice":
              //   if (mode != "game_choice") {
              //     GetStorage().write('mode', "game_choice");
              //     Get.offAllNamed(Routes.THEATER_GAME_CHOICE_GAME);
              //   }
              //   break;
              // case "game_music_shake":
              //   if (mode != "game_music_shake") {
              //     GetStorage().write('mode', "game_music_shake");
              //     Get.offAllNamed(Routes.THEATER_GAME_SHAKE_GAME);
              //   }
              //   break;
              // case "game_music_shake_done":
              //   if (mode != "game_music_shake_done") {
              //     GetStorage().write('mode', "game_music_shake_done");
              //     Get.offAllNamed(Routes.THEATER_GAME_SHAKE_GAME_DONE);
              //   }
              //   break;
              // case "game_chat":
              //   if (mode != "game_chat") {
              //     GetStorage().write('mode', "game_chat");
              //     Get.offAllNamed(Routes.THEATER_GAME_CHAT_GAME);
              //   }
              //   break;
              // case "game_chat_done":
              //   if (mode != "game_chat_done") {
              //     GetStorage().write('mode', "game_chat_done");
              //     Get.offAllNamed(Routes.THEATER_GAME_CHAT_GAME_DONE);
              //   }
              //   break;
              // case "game_call_humbaba":
              //   if (mode != "game_call_humbaba") {
              //     GetStorage().write('mode', "game_call_humbaba");
              //     Get.offAllNamed(Routes.THEATER_GAME_CALL_HUMBABA_GAME);
              //   }
              //   break;
              // case "game_call_humbaba_done":
              //   if (mode != "game_call_humbaba_done") {
              //     GetStorage().write('mode', "game_call_humbaba_done");
              //     Get.offAllNamed(Routes.THEATER_GAME_CALL_HUMBABA_GAME_DONE);
              //   }
              //   break;
              // case "game_chat_and_call":
              //   if (mode != "game_chat_and_call") {
              //     GetStorage().write('mode', "game_chat_and_call");
              //     Get.offAllNamed(Routes.THEATER_GAME_CHAT_AND_CALL_GAME);
              //   }
              //   break;

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
