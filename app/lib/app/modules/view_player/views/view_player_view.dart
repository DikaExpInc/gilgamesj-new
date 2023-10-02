import 'package:app/app/modules/view_player/controllers/view_player_controller.dart';
import 'package:app/app/modules/view_player/views/widgets/player_widget.dart';
import 'package:app/app/widgets/no_data.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class ViewPlayerView extends GetView<ViewPlayerController> {
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
            image: AssetImage("assets/images/background4.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WELKOM (${controller.box.read('teamName')})",
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        height: 3.0,
                        width: 80.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Voer je namen in.",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
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
                child: GetBuilder<ViewPlayerController>(
                  builder: (controller) => controller
                              .playerListModel?.statusCode ==
                          200
                      ? controller.playerListModel!.items!.length != 0
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 48.0),
                              child: ListView.builder(
                                itemCount:
                                    controller.playerListModel!.items!.length,
                                itemBuilder: (context, index) {
                                  final textController =
                                      controller.playerNameControllers[index];
                                  return PlayerWidget(
                                    autoFocus: index == 0,
                                    nameController: textController,
                                    status: controller.playerListModel!
                                                .items![index].statusPlay ==
                                            "Y"
                                        ? "Playing"
                                        : "",
                                    index: index,
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
                    Obx(() {
                      return controller.isButtonVisible.value
                          ? InkWell(
                              onTap: () => {controller.onNext()},
                              child: Container(
                                width: mWidth / 4,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal:
                                        MediaQuery.of(context).size.width > 600
                                            ? 50
                                            : 20),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/bg_btn.png"),
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
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? 16
                                                : 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox();
                    }),
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
