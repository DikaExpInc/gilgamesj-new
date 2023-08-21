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
  String? teamName = GetStorage().read('teamName');
  if (teamName != null && teamName.isNotEmpty) {
    initialRoute =
        Routes.VIEW_PLAYER; // Ganti rute jika total player telah diisi

    // Cek apakah data stage telah diisi
    String? mode = GetStorage().read('mode');
    if (mode != null && mode.isNotEmpty) {
      switch (mode) {
        case 'value':
          initialRoute = Routes.LOCK_MUSIC;
          break;
        case 'value1':
          initialRoute = Routes.LOCK_MUSIC;
          break;
        case 'value2':
          initialRoute = Routes.LOCK_MUSIC;
          break;
        case 'value3':
          initialRoute = Routes.LOCK_MUSIC;
          break;
        case 'value4':
          initialRoute = Routes.LOCK_MUSIC;
          break;
        case 'value5':
          initialRoute = Routes.LOCK_MUSIC;
          break;
        case 'value6':
          initialRoute = Routes.LOCK_MUSIC;
          break;
        default:
      }
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
