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
      body: Container(
        width: mWidth,
        height: mHeight,
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
                "BEDENK EEN TEAMNAAM",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/welcome-image.png'),
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: mWidth / 1.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0),
                                  BlendMode.srcOver),
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
                              color: Colors.white,
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
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0),
                                          BlendMode.srcOver),
                                      image: AssetImage(
                                          "assets/images/bg_input.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "${controller.totalPlayer}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
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
                                  image: AssetImage("assets/images/bg_btn.png"),
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
                                      color: Colors.white,
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
    );
  }
}
