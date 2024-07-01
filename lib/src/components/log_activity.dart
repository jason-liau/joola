import 'package:flutter/material.dart';
import 'package:joola/src/components/home_button.dart';
import 'package:joola/src/pages/calendar.dart';

class LogActivity extends StatelessWidget {
  const LogActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HomeButton(
      text: 'Log Activity',
      icon: Icons.add_circle_outline,
      color: const Color.fromARGB(255, 218, 115, 171),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return const CalendarPage();
          })
        );
      }
    );
  }
}