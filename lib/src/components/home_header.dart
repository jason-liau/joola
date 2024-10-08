import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String text;

  const HomeHeader({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          )
        ),
      ),
    );
  }
}