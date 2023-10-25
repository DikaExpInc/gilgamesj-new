import 'package:flutter/material.dart';

class GuessWidget extends StatelessWidget {
  final String title;
  final bool position;
  final VoidCallback press;

  const GuessWidget({
    Key? key,
    required this.title,
    required this.position,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Row(
        mainAxisAlignment:
            position ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            width: MediaQuery.sizeOf(context).width / 2.5, // Lebar 100%
            padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: MediaQuery.of(context).size.width > 600 ? 50 : 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg-choice.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              textAlign: position ? TextAlign.end : TextAlign.start,
              maxLines: 8,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
