import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gilgamesj/app/modules/introduction/controllers/introduction_controller.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:gilgamesj/app/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionView extends GetView<IntroductionController> {
  final box = GetStorage();
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        width: mWidth,
        height: mHeight,
        // color: colors[0],
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0), BlendMode.srcOver),
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
          pages: [
            PageViewModel(
              title: 'Avontuur',
              image: buildImage('assets/images/intro_adventurer.png'),
              decoration: getPageDecoration(),
              body:
                  'Je gaat niet alleen een theatervoorstelling zien, maar je gaat op avontuur. Voordat je begint, moet je echter eerst op zoek gaan naar de spelregels. Hiervoor kun je de camera gebruiken in het volgende scherm.',
            ),
            PageViewModel(
              title: 'Reglement',
              body:
                  'Deze smartphone heeft regels die door zijn gebruikers moeten worden nageleefd, zodat gebruikers veilig zijn voor de gevaren die deze smartphone met zich meebrengt',
              image: buildImage('assets/images/intro_book.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Tablet',
              body:
                  'Leg de tablet wanneer de voorstelling speelt neer onder je stoel.',
              image: buildImage('assets/images/intro_qrcode.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Container(
              width: 100,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.primary,
              ),
              child: Center(
                child: Text(
                  'VERDER',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text('DOORGAAN'),
          onSkip: () => goToHome(context),
          next: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.primary,
            ),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
          dotsDecorator: getDotDecoration(),
        ),
      ),
    );
  }

  void goToHome(context) {
    box.write('isBoardingDone', true);
    Get.offAllNamed(Routes.RULES, arguments: {"from": "introduction"});
  }

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.white70,
        activeColor: AppColor.primary,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        bodyTextStyle: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: Colors.white70,
        ),
        imagePadding: EdgeInsets.all(24),
        // pageColor: Colors.white70,
      );
}
