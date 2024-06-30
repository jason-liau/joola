import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String text;

  const HomeHeader({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        )
      ),
    );
  }
}