import 'package:flutter/material.dart';

class ProfileAbjad extends StatelessWidget {
  final String title;

  const ProfileAbjad({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 64.0,
      ),
      child: Text(
        '${title}',
        style: const TextStyle(
          fontFamily: 'Centrion',
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
