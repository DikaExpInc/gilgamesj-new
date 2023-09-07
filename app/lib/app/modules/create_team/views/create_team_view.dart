import 'package:app/app/modules/create_team/controllers/create_team_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class CreateTeamView extends GetView<CreateTeamController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: mWidth,
          height: mHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.0), BlendMode.srcOver),
              image: AssetImage("assets/images/background3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "BEDENK EEN TEAM NAAM",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                // controller.rotatingImage,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Schatten uit het',
                      style: TextStyle(
                        color: Color(0xff79684B),
                        fontSize: 68,
                      ),
                    ),
                    Text(
                      'Oosten',
                      style: TextStyle(
                        color: Color(0xff79684B),
                        fontSize: 128,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(
                              'TEAM NAAM',
                              style: TextStyle(
                                color: Color(0xFF79684B),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            width: mWidth / 1.8,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors
                                      .black, // Color of the bottom border
                                  width: 2.0, // Width of the bottom border
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: controller.teamNameC,
                              style: TextStyle(color: Colors.black),
                              onChanged: (value) {
                                controller.isButtonVisible(value.isNotEmpty);
                              },
                              decoration: InputDecoration(
                                hintText: 'VOER HIER JE NAAM IN',
                                hintStyle: TextStyle(color: Colors.white54),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: Text(
                              'SPELERS',
                              style: TextStyle(
                                color: Color(0xFF79684B),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: controller.subsPlayer,
                                child: SvgPicture.asset(
                                  "assets/icons/subtract.svg",
                                ),
                              ),
                              Obx(
                                () => Container(
                                    width: mWidth / 6,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black, // Border color
                                        width: 2.0, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Border radius
                                    ),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          "${controller.totalPlayer}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              InkWell(
                                onTap: controller.addPlayer,
                                child: SvgPicture.asset(
                                  "assets/icons/plus.svg",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      return controller.isButtonVisible.value
                          ? InkWell(
                              onTap: () => controller.addTeamName(),
                              child: Container(
                                width: 200,
                                height: 50,
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
                                        fontSize: 16,
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
                      height: 20,
                    ),
                    Obx(
                      () => controller.hasReconnect.value
                          ? InkWell(
                              onTap: () => controller.reconnect(),
                              child: Container(
                                width: 200,
                                height: 50,
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
                                      "RECONNECT",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
