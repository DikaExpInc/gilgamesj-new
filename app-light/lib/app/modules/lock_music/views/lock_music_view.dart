import 'dart:async';

import 'package:app/app/modules/lock_music/controllers/lock_music_controller.dart';
import 'package:app/app/modules/lock_music/views/components/password_music.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class LockMusicView extends GetView<LockMusicController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
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
                Colors.black.withOpacity(0), BlendMode.srcOver),
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () => {controller.playAudioSequenceFromLockCode()},
                  child: Image.asset(
                    "assets/images/btn_audio.png",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Wachtwoord",
                  style: TextStyle(
                    fontSize: mWidth > 600 ? 26 : 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Flexible(
              child: PasscodeScreen(
                passwordEnteredCallback: _onPasscodeEntered,
                cancelButton: Text('Rug'),
                deleteButton: Text('Verwijderen'),
                shouldTriggerVerification: _verificationNotifier.stream,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.RULES, arguments: {"from": "start"});
          },
          child: Icon(Icons.view_headline_rounded), // Icon tombol floating
          backgroundColor:
              AppColor.primary, // Warna latar belakang tombol floating
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  _onPasscodeEntered(String enteredPasscode) async {
    bool isValid =
        controller.box.read('tuts').toString() == enteredPasscode.toString();
    _verificationNotifier.add(isValid);
  }
}
