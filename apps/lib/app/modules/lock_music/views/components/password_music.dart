library passcode_screen;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/lock_music/views/components/circle_music.dart';
import 'package:gilgamesj/app/modules/lock_music/views/components/keyboard_music.dart';
import 'package:gilgamesj/app/modules/lock_music/views/components/shake_curve_music.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';

typedef PasswordEnteredCallback = void Function(String text);
typedef IsValidCallback = void Function();
typedef CancelCallback = void Function();

class PasscodeScreen extends StatefulWidget {
  final int passwordDigits;
  final PasswordEnteredCallback passwordEnteredCallback;
  // Cancel button and delete button will be switched based on the screen state
  final Widget cancelButton;
  final Widget deleteButton;
  final Stream<bool> shouldTriggerVerification;
  final CircleUIConfig circleUIConfig;
  final KeyboardUIConfig keyboardUIConfig;

  //isValidCallback will be invoked after passcode screen will pop.
  final IsValidCallback? isValidCallback;
  final CancelCallback? cancelCallback;

  final Color? backgroundColor;
  final Widget? bottomWidget;
  final List<String>? digits;

  PasscodeScreen({
    Key? key,
    this.passwordDigits = 4,
    required this.passwordEnteredCallback,
    required this.cancelButton,
    required this.deleteButton,
    required this.shouldTriggerVerification,
    this.isValidCallback,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    this.bottomWidget,
    this.backgroundColor,
    this.cancelCallback,
    this.digits,
  })  : circleUIConfig = circleUIConfig ?? const CircleUIConfig(),
        keyboardUIConfig = keyboardUIConfig ?? const KeyboardUIConfig(),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen>
    with SingleTickerProviderStateMixin {
  late StreamSubscription<bool> streamSubscription;
  String enteredPasscode = '';
  late AnimationController controller;
  late Animation<double> animation;

  @override
  initState() {
    super.initState();
    streamSubscription = widget.shouldTriggerVerification
        .listen((isValid) => _showValidation(isValid));
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: ShakeCurve());
    animation = Tween(begin: 0.0, end: 10.0).animate(curve as Animation<double>)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            enteredPasscode = '';
            controller.value = 0;
          });
        }
      })
      ..addListener(() {
        setState(() {
          // the animation object’s value is the changed state
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return _buildPortraitPasscodeScreen();
          },
        ),
      ),
    );
  }

  _buildPortraitPasscodeScreen() => Stack(
        children: [
          Positioned(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildCircles(),
                    ),
                  ),
                  _buildKeyboard(),
                  widget.bottomWidget ?? Container()
                ],
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomRight,
              child: _buildDeleteButton(),
            ),
          ),
        ],
      );

  _buildKeyboard() => Container(
        child: KeyboardMusic(
          onKeyboardTap: _onKeyboardButtonPressed,
          keyboardUIConfig: widget.keyboardUIConfig,
          digits: widget.digits,
        ),
      );

  List<Widget> _buildCircles() {
    var list = <Widget>[];
    var config = widget.circleUIConfig;
    var extraSize = animation.value;
    // dynamic passcode
    // for (int i = 0; i < widget.passwordDigits; i++) {
    //   list.add(
    //     Container(
    //       margin: EdgeInsets.all(8),
    //       child: CircleMusic(
    //         filled: i < enteredPasscode.length,
    //         circleUIConfig: config,
    //         extraSize: extraSize,
    //       ),
    //     ),
    //   );
    // }
    // static code
    list.add(
      Container(
        margin: EdgeInsets.all(8),
        child: CircleMusic(
          colorFill: Color(0xFFFFFFFF),
          colorBorder: Color(0xFFFFFFFF),
          filled: 0 < enteredPasscode.length,
          circleUIConfig: config,
          extraSize: extraSize,
        ),
      ),
    );
    list.add(
      Container(
        margin: EdgeInsets.all(8),
        child: CircleMusic(
          colorFill: Color(0xFFFFFFFF),
          colorBorder: Color(0xFFFFFFFF),
          filled: 1 < enteredPasscode.length,
          circleUIConfig: config,
          extraSize: extraSize,
        ),
      ),
    );
    list.add(
      Container(
        margin: EdgeInsets.all(8),
        child: CircleMusic(
          colorFill: Color(0xFFFFFFFF),
          colorBorder: Color(0xFFFFFFFF),
          filled: 2 < enteredPasscode.length,
          circleUIConfig: config,
          extraSize: extraSize,
        ),
      ),
    );
    list.add(
      Container(
        margin: EdgeInsets.all(8),
        child: CircleMusic(
          colorFill: Color(0xFFFFFFFF),
          colorBorder: Color(0xFFFFFFFF),
          filled: 3 < enteredPasscode.length,
          circleUIConfig: config,
          extraSize: extraSize,
        ),
      ),
    );
    return list;
  }

  _onDeleteCancelButtonPressed() {
    if (enteredPasscode.length > 0) {
      setState(() {
        enteredPasscode =
            enteredPasscode.substring(0, enteredPasscode.length - 1);
      });
    } else {
      if (widget.cancelCallback != null) {
        widget.cancelCallback!();
      }
      Get.toNamed(Routes.START);
    }
  }

  _onKeyboardButtonPressed(String text) {
    if (text == KeyboardMusic.deleteButton) {
      _onDeleteCancelButtonPressed();
      return;
    }
    setState(() {
      if (enteredPasscode.length < widget.passwordDigits) {
        enteredPasscode += text;
        if (enteredPasscode.length == widget.passwordDigits) {
          widget.passwordEnteredCallback(enteredPasscode);
        }
      }
    });
  }

  @override
  didUpdateWidget(PasscodeScreen old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
    if (widget.shouldTriggerVerification != old.shouldTriggerVerification) {
      streamSubscription.cancel();
      streamSubscription = widget.shouldTriggerVerification
          .listen((isValid) => _showValidation(isValid));
    }
  }

  @override
  dispose() {
    controller.dispose();
    streamSubscription.cancel();
    super.dispose();
  }

  _showValidation(bool isValid) {
    if (isValid) {
      Get.offNamed(Routes.HOME);
    } else {
      controller.forward();
    }
  }

  _validationCallback() {
    if (widget.isValidCallback != null) {
      widget.isValidCallback!();
    } else {
      print(
          "You didn't implement validation callback. Please handle a state by yourself then.");
    }
  }

  Widget _buildDeleteButton() {
    return Container(
      child: CupertinoButton(
        onPressed: _onDeleteCancelButtonPressed,
        child: Container(
          margin: widget.keyboardUIConfig.digitInnerMargin,
          child: enteredPasscode.length == 0
              ? widget.cancelButton
              : widget.deleteButton,
        ),
      ),
    );
  }
}
