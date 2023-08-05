import 'dart:async';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BonusCameraController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    requestCameraPermission();
  }

  Future<void> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      // Camera permission granted
    } else if (status.isDenied) {
      // Camera permission denied
    } else if (status.isPermanentlyDenied) {
      // Camera permission permanently denied, navigate to app settings
      openAppSettings();
    }
  }
}
