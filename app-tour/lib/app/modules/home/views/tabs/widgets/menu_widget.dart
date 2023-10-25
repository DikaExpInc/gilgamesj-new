import 'package:app/app/widgets/pulse_icon.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final bool status;
  final String icon;
  final String title;
  final VoidCallback press;
  const MenuWidget({
    Key? key,
    required this.status,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: MediaQuery.of(context).size.width > 600 ? 90 : 65,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  icon,
                  height: MediaQuery.of(context).size.width > 600 ? 74 : 50,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: status ? PulseIcon() : Container(),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 10,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
