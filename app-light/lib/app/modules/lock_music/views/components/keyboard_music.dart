import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef KeyboardTapCallback = void Function(String text);

@immutable
class KeyboardUIConfig {
  //Digits have a round thin borders, [digitBorderWidth] define their thickness
  final double digitBorderWidth;
  final TextStyle digitTextStyle;
  final TextStyle deleteButtonTextStyle;
  final Color primaryColor;
  final Color digitFillColor;
  final EdgeInsetsGeometry keyboardRowMargin;
  final EdgeInsetsGeometry digitInnerMargin;

  //Size for the keyboard can be define and provided from the app.
  //If it will not be provided the size will be adjusted to a screen size.
  final Size? keyboardSize;

  const KeyboardUIConfig({
    this.digitBorderWidth = 1,
    this.keyboardRowMargin = const EdgeInsets.only(top: 15, left: 4, right: 4),
    this.digitInnerMargin = const EdgeInsets.all(24),
    this.primaryColor = Colors.white,
    this.digitFillColor = Colors.transparent,
    this.digitTextStyle = const TextStyle(fontSize: 30, color: Colors.white),
    this.deleteButtonTextStyle =
        const TextStyle(fontSize: 16, color: Colors.white),
    this.keyboardSize,
  });
}

class KeyboardMusic extends StatelessWidget {
  final KeyboardUIConfig keyboardUIConfig;
  final KeyboardTapCallback onKeyboardTap;
  final _focusNode = FocusNode();
  static String deleteButton = 'keyboard_delete_button';

  //should have a proper order [1...9, 0]
  final List<String>? digits;

  KeyboardMusic({
    Key? key,
    required this.keyboardUIConfig,
    required this.onKeyboardTap,
    this.digits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildKeyboard(context);

  Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  Widget _buildKeyboard(BuildContext context) {
    List<String> keyboardItems = List.filled(8, '0');
    if (digits == null || digits!.isEmpty) {
      keyboardItems = [
        'assets/images/note_do.png',
        'assets/images/note_re.png',
        'assets/images/note_mi.png',
        'assets/images/note_fa.png',
        'assets/images/note_sol.png',
        'assets/images/note_la.png',
        'assets/images/note_ti.png',
        'assets/images/note_do2.png'
      ];
    } else {
      keyboardItems = digits!;
    }
    final screenSize = MediaQuery.of(context).size;
    Orientation orientation = getScreenOrientation(context);
    final keyboardHeight = orientation == Orientation.portrait
        ? screenSize.height / 3
        : screenSize.height / 2;
    final keyboardWidth = keyboardHeight * 3 / 4;
    final keyboardSize = this.keyboardUIConfig.keyboardSize != null
        ? this.keyboardUIConfig.keyboardSize!
        : Size(keyboardWidth, keyboardHeight);
    return Container(
      width: keyboardSize.width,
      height: keyboardSize.height,
      margin: EdgeInsets.only(top: 16),
      child: RawKeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKey: (event) {
          if (event is RawKeyUpEvent) {
            if (keyboardItems.contains(event.data.keyLabel)) {
              onKeyboardTap(event.logicalKey.keyLabel);
              return;
            }
            if (event.logicalKey.keyLabel == 'Backspace' ||
                event.logicalKey.keyLabel == 'Delete') {
              onKeyboardTap(KeyboardMusic.deleteButton);
              return;
            }
          }
        },
        child: AlignedGrid(
          keyboardSize: keyboardSize,
          children: List.generate(8, (index) {
            return _buildKeyboardDigit(keyboardItems[index], index.toString());
          }),
        ),
      ),
    );
  }

  Widget _buildKeyboardDigit(String text, String index) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: keyboardUIConfig.primaryColor.withOpacity(0.4),
          onTap: () {
            final AudioCache audioCache =
                AudioCache(prefix: 'assets/audios/tuts/');
            int tutsNumber = int.parse(index) + 1;
            audioCache.play('' + tutsNumber.toString() + '.mp3');
            onKeyboardTap(tutsNumber.toString());
          },
          child: Container(
            child: Container(
              child: Center(child: Image.asset(text, width: 350)),
            ),
          ),
        ),
      ),
    );
  }
}

class AlignedGrid extends StatelessWidget {
  final double runSpacing = 4;
  final double spacing = 4;
  final int listSize;
  final columns = 3;
  final List<Widget> children;
  final Size keyboardSize;

  const AlignedGrid(
      {Key? key, required this.children, required this.keyboardSize})
      : listSize = children.length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final primarySize = keyboardSize.width > keyboardSize.height
        ? keyboardSize.height
        : keyboardSize.width;
    final itemSize = (primarySize - runSpacing * (columns - 1)) / columns;
    return Wrap(
      runSpacing: runSpacing,
      spacing: spacing,
      alignment: WrapAlignment.center,
      children: children
          .map((item) => Container(
                width: itemSize,
                height: itemSize,
                child: item,
              ))
          .toList(growable: false),
    );
  }
}
