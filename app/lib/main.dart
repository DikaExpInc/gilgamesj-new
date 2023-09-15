import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/controllers/page_all_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await Permission.camera.request();
  await GetStorage.init();
  Get.put(PageAllController(), permanent: true);

  String initialRoute =
      AppPages.INITIAL; // Rute default jika tidak ada data yang diisi

  // Cek apakah data team name telah diisi
  // initialRoute = Routes.PRE_GAME_ITEMS;

  String? teamName = GetStorage().read('teamName');
  if (teamName != null && teamName.isNotEmpty) {
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
        case "game_descibel":
          initialRoute = Routes.PRE_GAME_DESCIBEL_GAME;
          break;
        case "game_music":
          initialRoute = Routes.PRE_GAME_MUSIC_GAME;
          break;
        case "game_music_theater":
          initialRoute = Routes.PRE_GAME_MUSIC_THEATER_GAME;
          break;
        case "game_shake":
          initialRoute = Routes.PRE_GAME_SHAKE_GAME;
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

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    ),
  );
}
