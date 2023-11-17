import 'package:gilgamesj_tour/app/modules/create_team/controllers/create_team_controller.dart';
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Schatten uit het',
                      style: TextStyle(
                        color: Color(0xff79684B),
                        fontSize: 68,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Oosten',
                      style: TextStyle(
                        color: Color(0xff79684B),
                        fontSize: 128,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Text(
                        'AANTAL SPELERS',
                        style: TextStyle(
                          color: Color(0xff79684B),
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: 400,
                          height: 60, // Atur lebar sesuai yang Anda inginkan
                          child: ElevatedButton(
                            onPressed: () {
                              controller.onSelectedTotalTeam(2);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: controller.totalPlayer == 2
                                  ? Color(0xff79684B)
                                  : Color.fromARGB(99, 149, 149, 149),
                              onPrimary: controller.totalPlayer == 2
                                  ? Colors.white
                                  : Colors.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.white, width: 2)),
                              elevation: 0,
                            ),
                            child: Text(
                              '2 SPELERS',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: 400,
                          height: 60, // Atur lebar sesuai yang Anda inginkan
                          child: ElevatedButton(
                            onPressed: () {
                              controller.onSelectedTotalTeam(3);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: controller.totalPlayer == 3
                                  ? Color(0xff79684B)
                                  : Color.fromARGB(99, 149, 149, 149),
                              onPrimary: controller.totalPlayer == 3
                                  ? Colors.white
                                  : Colors.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.white, width: 2)),
                              elevation: 0,
                            ),
                            child: Text(
                              '3 SPELERS',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: 400,
                          height: 60, // Atur lebar sesuai yang Anda inginkan
                          child: ElevatedButton(
                            onPressed: () {
                              controller.onSelectedTotalTeam(4);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: controller.totalPlayer == 4
                                  ? Color(0xff79684B)
                                  : Color.fromARGB(99, 149, 149, 149),
                              onPrimary: controller.totalPlayer == 4
                                  ? Colors.white
                                  : Colors.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.white, width: 2)),
                              elevation: 0,
                            ),
                            child: Text(
                              '4 SPELERS',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
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
