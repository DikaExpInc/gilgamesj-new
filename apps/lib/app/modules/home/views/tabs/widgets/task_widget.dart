import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final bool status;
  final String title;
  final String desc;
  final VoidCallback press;

  const TaskWidget({
    Key? key,
    required this.status,
    required this.title,
    required this.desc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !status
        ? InkWell(
            onTap: press,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity, // Lebar 100%
              padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal:
                      MediaQuery.of(context).size.width > 600 ? 50 : 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_task.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
