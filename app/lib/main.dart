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
        Routes.CREATE_PLAYER; // Ganti rute jika team name telah diisi

    // Cek apakah data total player telah diisi
    String? totalPlayer = GetStorage().read('totalPlayer');
    if (totalPlayer != null && totalPlayer.isNotEmpty) {
      initialRoute =
          Routes.VIEW_PLAYER; // Ganti rute jika total player telah diisi

      // Cek apakah data stage telah diisi
      String? stageID = GetStorage().read('stage_id');
      if (stageID != null && stageID.isNotEmpty) {
        initialRoute =
            Routes.LOCK_MUSIC; // Ganti rute jika total player telah diisi
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
