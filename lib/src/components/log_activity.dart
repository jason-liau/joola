import 'package:flutter/material.dart';
import 'package:joola/src/components/home_button.dart';
import 'package:joola/src/components/settings_popup.dart';
import 'package:joola/src/pages/calendar.dart';
import 'package:joola/src/utils/utils.dart';

class LogActivity extends StatelessWidget {
  const LogActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HomeButton(
      text: 'Log Activity',
      icon: Icons.add_circle_outline,
      image: 'assets/images/log_activity.png',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [const CalendarPage(),
                  TextButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 114, 46, 231),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: const Text('Back', style: TextStyle(color: Colors.white))
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          })
        );
      }
    );
  }
}