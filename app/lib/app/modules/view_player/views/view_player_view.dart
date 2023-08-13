import 'package:app/app/modules/view_player/controllers/view_player_controller.dart';
import 'package:app/app/modules/view_player/views/widgets/player_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ViewPlayerView extends GetView<ViewPlayerController> {
  late double mWidth;
  late double mHeight;

  Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = getScreenOrientation(context);
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: mWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: mHeight / 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Spelerslijst",
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      height: 3.0,
                      width: 80.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "je kunt de naam wijzigen door op de kaartspeler te klikken",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  PlayerWidget(
                    name: "Player 1",
                    status: "Played",
                  ),
                  PlayerWidget(
                    name: "Player 2",
                    status: "",
                  ),
                  PlayerWidget(
                    name: "Player 3",
                    status: "",
                  ),
                  PlayerWidget(
                    name: "Player 4",
                    status: "",
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => {controller.onNext()},
                    child: Container(
                      width: mWidth / 4,
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: MediaQuery.of(context).size.width > 600
                              ? 50
                              : 20),
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
                            "ZIE INLEIDING",
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
      ),
    );
  }
}
