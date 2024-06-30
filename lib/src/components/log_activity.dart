import 'package:flutter/material.dart';
import 'package:joola/src/components/home_button.dart';

class LogActivity extends StatelessWidget {
  const LogActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const HomeButton(
      text: 'Log Activity',
      icon: Icons.add_circle_outline,
      color: Color.fromARGB(255, 218, 115, 171),
      onTap: null
    );
  }
}