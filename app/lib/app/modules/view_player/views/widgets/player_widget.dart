import 'package:app/app/modules/view_player/controllers/view_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerWidget extends GetView<ViewPlayerController> {
  final String name;
  final String status;

  const PlayerWidget({
    Key? key,
    required this.name,
    required this.status,
  }) : super(key: key);

  Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
    late double mWidth;
    mWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () => controller.showPlayerDialog(),
      child: Container(
        width: mWidth / 1.2, // Lebar 100%
        margin: EdgeInsets.only(bottom: 40),
        padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: MediaQuery.of(context).size.width > 600 ? 50 : 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_task.png"),
            fit: BoxFit.fill,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "${name}",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
                      color: Colors.white,
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
