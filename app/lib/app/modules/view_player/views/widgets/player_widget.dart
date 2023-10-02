import 'package:app/app/modules/view_player/controllers/view_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerWidget extends GetView<ViewPlayerController> {
  final TextEditingController nameController;
  final String status;
  final int index;
  final bool autoFocus;

  const PlayerWidget({
    Key? key,
    required this.nameController,
    required this.status,
    required this.index,
    required this.autoFocus,
  }) : super(key: key);

  Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
    late double mWidth;
    mWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Text(
              "SPELER ${index + 1}",
              style: TextStyle(
                color: Color(0xff79684B),
              ),
            ),
          ),
          Container(
            width: mWidth / 1.6, // Lebar 100%
            padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: MediaQuery.of(context).size.width > 600 ? 50 : 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black, // Color of the bottom border
                  width: 2.0, // Width of the bottom border
                ),
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: mWidth / 3,
                  child: TextField(
                    autofocus: autoFocus,
                    controller: nameController,
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      // controller.isButtonVisible(value.isNotEmpty);
                      // Periksa apakah semua TextField memiliki nilai
                      // isAllTextFieldsFilled = ;
                      controller.isButtonVisible(controller
                          .playerNameControllers
                          .every((controller) => controller.text.isNotEmpty));
                    },
                    decoration: InputDecoration(
                      // hintText: 'VOER HIER JE NAAM IN',
                      // hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  child: Text(
                    "${status}",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
