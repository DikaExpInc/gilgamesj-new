import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/no_data.dart';
import 'widgets/player_widget.dart';
import '../controllers/change_player_controller.dart';

// ignore: must_be_immutable
class ChangePlayerView extends GetView<ChangePlayerController> {
  late double mWidth;
  late double mHeight;

  Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "made by",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.asset('assets/images/logo-1.png'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WELKOM ${controller.box.read('teamName')}",
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
                      "Voer je namen in.",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GetBuilder<ChangePlayerController>(
                  builder: (controller) =>
                      controller.playerListModel?.statusCode == 200
                          ? controller.playerListModel!.items!.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 48.0),
                                  child: ListView.builder(
                                    itemCount: controller
                                        .playerListModel!.items!.length,
                                    itemBuilder: (context, index) {
                                      return PlayerWidget(
                                        name: controller.playerListModel!
                                                    .items![index].username ==
                                                null
                                            ? "Player " +
                                                controller.playerListModel!
                                                    .items![index].playerNum
                                                    .toString()
                                            : controller.playerListModel!
                                                .items![index].username
                                                .toString(),
                                        status: controller.playerListModel!
                                                    .items![index].statusPlay ==
                                                "Y"
                                            ? "Playing"
                                            : "",
                                      );
                                    },
                                  ),
                                )
                              : NoData()
                          : controller.playerListModel?.statusCode == 204
                              ? Container(
                                  child: Text("Empty"),
                                )
                              : NoData(),
                ),
              ),
              Center(
                child: Column(
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
                              "DOORGAAN",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
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
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
