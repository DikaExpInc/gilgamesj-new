import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RulesWidget extends StatelessWidget {
  final String name;
  final String description;
  final String images;

  const RulesWidget({
    Key? key,
    required this.name,
    required this.description,
    required this.images,
  }) : super(key: key);

  Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = getScreenOrientation(context);
    late double mWidth;
    mWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: 40),
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_task.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 40),
                child: Image.asset(
                  'assets/images/artefact.png',
                  height: orientation == Orientation.portrait
                      ? (MediaQuery.of(context).size.width > 600 ? 90 : 60)
                      : 80,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: mWidth / 1.6,
                    child: Text(
                      "${name}",
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    width: mWidth / 1.8,
                    child: Text(
                      "${description}",
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
