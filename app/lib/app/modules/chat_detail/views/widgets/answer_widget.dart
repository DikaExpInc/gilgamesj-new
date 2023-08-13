import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  final String title;
  final VoidCallback press;

  const AnswerWidget({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        width: double.infinity, // Lebar 100%
        padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: MediaQuery.of(context).size.width > 600 ? 50 : 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_task.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 60 / 100,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Image.asset(
              'assets/images/ic_send.png',
            ),
          ],
        ),
      ),
    );
  }
}
