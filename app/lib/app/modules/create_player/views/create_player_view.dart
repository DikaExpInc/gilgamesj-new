import 'package:app/app/modules/create_player/controllers/create_player_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CreatePlayerView extends GetView<CreatePlayerController> {
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
                Colors.black.withOpacity(0.5), BlendMode.srcOver),
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
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
              Text(
                "VUL HET TEAMNUMMER IN",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                width: mWidth / 1.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0), BlendMode.srcOver),
                    image: AssetImage("assets/images/bg_input.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: TextField(
                  controller: controller.teamNameC,
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    controller.isButtonVisible(value.isNotEmpty);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Vul het aantal spelers in',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
              Obx(() {
                return controller.isButtonVisible.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => controller.addTeamName(),
                            child: Container(
                              width: 200,
                              height: 50,
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
