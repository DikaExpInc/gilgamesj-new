import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  final VoidCallback onClick;
  final String name;
  final String images;

  const ContactWidget({
    Key? key,
    required this.onClick,
    required this.name,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 24),
      child: InkWell(
        onTap: onClick,
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(
                      images), // Menggunakan AssetImage sebagai ImageProvider
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 36,
            ),
            Text(
              '${name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
