import 'package:app/app/controllers/page_all_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BonusDialog extends GetView<PageAllController> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 3,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.srcOver),
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("assets/images/bonus_icon.png"),
            SizedBox(height: 16.0),
            Text(
              'Congratulation!, You have a chance to play',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'BONUS LEVEL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => controller.showSkipBonusDialog(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal:
                            MediaQuery.of(context).size.width > 600 ? 50 : 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg_btn.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? 16
                                : 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                InkWell(
                  onTap: () => {
                    Get.back(),
                    Get.offAllNamed(
                      Routes.BONUS,
                    ),
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal:
                            MediaQuery.of(context).size.width > 600 ? 50 : 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg_btn.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Play",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? 16
                                : 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
