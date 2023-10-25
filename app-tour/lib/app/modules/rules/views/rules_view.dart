import 'package:app/app/modules/rules/controllers/rules_controller.dart';
import 'package:app/app/modules/rules/views/widgets/rules_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class RulesView extends GetView<RulesController> {
  late double mWidth;
  late double mHeight;
  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: mHeight / 15,
            left: mWidth / 10,
            right: mWidth / 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Rules",
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
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 80),
                      RulesWidget(
                        name: "The bel and the ritual",
                        description:
                            "In the performance, the phone can only be used when it clearly indicates it. When not in use, gently place it next to or under you.",
                        images: "images",
                      ),
                      RulesWidget(
                        name: "The smoke of Urus",
                        description:
                            "You are searching the phone for the smoke of Urus. These are visions of the future, and they are extremely important.",
                        images: "images",
                      ),
                      RulesWidget(
                        name: "The Clay Tablets",
                        description:
                            "When you have found 5 visions, you have discovered a clay tablet. These are needed to store the stories for future generations to read.",
                        images: "images",
                      ),
                      RulesWidget(
                        name: "Escape from the Underworld",
                        description:
                            "You may not spend more than 10 minutes on the phone. After that, you must escape eternal addiction. To do this, you all perform a ritual together. However, you can only find.",
                        images: "images",
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => {controller.onNext()}, // Add your onTap logic here
                child: Container(
                  width: mWidth / 4,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal:
                        MediaQuery.of(context).size.width > 600 ? 50 : 20,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg_btn.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "READY",
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width > 600 ? 16 : 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
