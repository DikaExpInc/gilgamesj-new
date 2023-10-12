import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/choice_role_controller.dart';

class ChoiceRoleView extends GetView<ChoiceRoleController> {
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
              Colors.black.withOpacity(0.0), BlendMode.srcOver),
          image: AssetImage("assets/images/background3.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => {controller.chooseRole('late')},
                    child: Obx(
                      () => Text(
                        'Late Comers',
                        style: TextStyle(
                            fontWeight: controller.selectedRole.value == "late"
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ),
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
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.asset('assets/images/logo_color.png'),
                      ),
                      Text(
                        "www.expinc.io",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Kinderen',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 45,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => {controller.chooseRole('children')},
                  child: Obx(
                    () => AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: mWidth / 3.3,
                      height: mHeight / 3.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: controller.selectedRole.value == "children"
                              ? AssetImage(
                                  "assets/images/role_children_active.png")
                              : AssetImage("assets/images/role_children.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => {controller.chooseRole('parent')},
                  child: Obx(
                    () => AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: mWidth / 3.3,
                      height: mHeight / 3.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: controller.selectedRole.value == "parent"
                              ? AssetImage(
                                  "assets/images/role_parent_active.png")
                              : AssetImage("assets/images/role_parent.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => {controller.chooseRole('disability')},
                  child: Obx(
                    () => AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: mWidth / 3.3,
                      height: mHeight / 3.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: controller.selectedRole.value == "disability"
                              ? AssetImage(
                                  "assets/images/role_mobility_active.png")
                              : AssetImage("assets/images/role_mobility.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => controller.selectedRole.value != ""
                  ? Container(
                      child: InkWell(
                        onTap: () => {controller.nextStep()},
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
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    ));
  }
}
