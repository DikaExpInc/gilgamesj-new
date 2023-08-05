import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/lock_screen/controllers/lock_screen_controller.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:pattern_lock/pattern_lock.dart';

class LockScreenView extends GetView<LockScreenController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    final List<int>? pattern =
        ModalRoute.of(context)!.settings.arguments as List<int>?;

    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: mWidth,
        height: mHeight,
        // color: colors[0],
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.srcOver),
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: Text(
                "use password pattern",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ),
            Flexible(
              child: PatternLock(
                selectedColor: Colors.red,
                notSelectedColor: Colors.white,
                pointRadius: 12,
                showInput: true,
                dimension: 3,
                relativePadding: 0.7,
                selectThreshold: 25,
                fillPoints: true,
                onInputComplete: (List<int> input) {
                  if (listEquals<int>(input, [0, 4, 1, 5])) {
                    Get.toNamed(Routes.HOME);
                  } else {
                    print('salah');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
