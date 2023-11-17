import 'package:gilgamesj_tour/app/controllers/page_all_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsDialog extends GetView<PageAllController> {
  final String image;
  final String title;
  final String description;

  ItemsDialog(
      {required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 3,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.0), BlendMode.srcOver),
            image: AssetImage("assets/images/background-modal.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "${image}",
              height: 100,
            ),
            SizedBox(height: 16.0),
            Text(
              '${title}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              '${description}',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
