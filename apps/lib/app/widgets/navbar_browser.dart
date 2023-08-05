// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:gilgamesj/app/style/app_color.dart';

class NavbarWidget extends StatelessWidget {
  late double mWidth;

  NavbarWidget({
    Key? key,
    required this.mWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => {Get.back()},
          child: Image.asset(
            "assets/images/ic_home.png",
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: mWidth / 2,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0), BlendMode.srcOver),
              image: AssetImage("assets/images/bg_input.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'http://www.bbc.com',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
        ),
        InkWell(
          onTap: () => {Get.toNamed(Routes.BROWSER_SEARCH)},
          child: Image.asset(
            "assets/images/ic_search.png",
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
