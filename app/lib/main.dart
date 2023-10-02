import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/controllers/page_all_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await Permission.camera.request();
  await GetStorage.init();
  // Buat instance controller
  PageAllController pageAllController = PageAllController();
  Get.put(PageAllController(), permanent: true);

  String initialRoute =
      AppPages.INITIAL; // Rute default jika tidak ada data yang diisi

  // Cek apakah data team name telah diisi
  // initialRoute = Routes.PRE_GAME_ITEMS;

  String? teamName = GetStorage().read('teamName');
  if (teamName != null && teamName.isNotEmpty) {
    pageAllController.autoLogin();
    initialRoute =
        Routes.VIEW_PLAYER; // Ganti rute jika total player telah diisi

    // Cek apakah data stage telah diisi
    String? mode = GetStorage().read('mode');
    if (mode != null && mode.isNotEmpty) {
      switch (mode) {
        case 'phone':
          initialRoute = Routes.INTRODUCTION;
          break;
        case 'clap':
          initialRoute = Routes.CLAP;
          break;
        case 'blank':
          initialRoute = Routes.BLANK;
          break;
        case 'light':
          initialRoute = Routes.LIGHT;
          break;
        case 'notification':
          initialRoute = Routes.NOTIFICATION;
          break;
        case 'group':
          initialRoute = Routes.GROUP;
          break;
        case 'performance':
          initialRoute = Routes.PERFORMANCE;
          break;
        case "pre_game":
          // initialRoute = Routes.INTRO;
          initialRoute = Routes.PRE_GAME_START;
          break;
        case "item":
          initialRoute = Routes.PRE_GAME_ITEMS;
          break;
        case "intro":
          initialRoute = Routes.PRE_GAME_SPLASH;
          break;
        case "go_to_theater":
          initialRoute = Routes.GO_THEATER;
          break;

        // Mini Game

        case "game_descibel":
          initialRoute = Routes.MINI_GAME_DESCIBEL_GAME;
          break;
        case "game_music":
          initialRoute = Routes.MINI_GAME_MUSIC_GAME;
          break;
        case "game_music_theater":
          initialRoute = Routes.MINI_GAME_MUSIC_THEATER_GAME;
          break;
        case "game_shake":
          initialRoute = Routes.MINI_GAME_SHAKE_GAME;
          break;

        // Theater Game

        case "game_light":
          initialRoute = Routes.THEATER_GAME_LIGHTNING_GAME;
          break;
        case "game_light_done":
          initialRoute = Routes.THEATER_GAME_LIGHTNING_GAME_DONE;
          break;
        case "game_star":
          initialRoute = Routes.THEATER_GAME_STAR_GAME;
          break;
        case "game_star_solving":
          initialRoute = Routes.THEATER_GAME_STAR_GAME_SOLVING;
          break;
        case "game_star_timer":
          initialRoute = Routes.THEATER_GAME_STAR_TIMER_GAME;
          break;
        case "game_star_done":
          initialRoute = Routes.THEATER_GAME_STAR_GAME_DONE;
          break;
        case "game_choice":
          initialRoute = Routes.THEATER_GAME_CHOICE_GAME;
          break;
        case "game_music_shake":
          initialRoute = Routes.THEATER_GAME_SHAKE_GAME;
          break;
        case "game_music_shake_done":
          initialRoute = Routes.THEATER_GAME_SHAKE_GAME_DONE;
          break;
        case "game_chat":
          initialRoute = Routes.THEATER_GAME_CHAT_GAME;
          break;
        case "game_chat_done":
          initialRoute = Routes.THEATER_GAME_CHAT_GAME_DONE;
          break;
        case "game_call_humbaba":
          initialRoute = Routes.THEATER_GAME_CALL_HUMBABA_GAME;
          break;
        case "game_call_humbaba_done":
          initialRoute = Routes.THEATER_GAME_CALL_HUMBABA_GAME_DONE;
          break;
        case "game_chat_and_call":
          initialRoute = Routes.THEATER_GAME_CHAT_AND_CALL_GAME;
          break;
        default:
      }
    }
  } else {
    String? mode = GetStorage().read('mode');
    if (mode != null && mode.isNotEmpty) {
      switch (mode) {
        case 'phone':
          initialRoute = Routes.INTRODUCTION;
          break;
        default:
          initialRoute = Routes.PRE_GAME_START;
          break;
      }
    } else {
      initialRoute = Routes.PRE_GAME_START;
    }
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      GetMaterialApp(
        title: "Application",
        initialRoute: initialRoute,
        getPages: AppPages.routes,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    );
  });
}
