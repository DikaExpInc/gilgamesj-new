import 'package:gilgamesj_tour/app/modules/phone_call/controllers/phone_call_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountdownTimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PhoneCallController countdownController =
        Get.put(PhoneCallController());

    return Obx(() {
      return countdownController.isIdleTimerRunning.value
          ? Text(
              "calling",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            )
          : Text(
              countdownController.time.value,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            );
    });
  }
}
