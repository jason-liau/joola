import 'package:flutter/material.dart';
import 'package:joola/src/components/home_button.dart';
import 'package:joola/src/components/settings_popup.dart';
import 'package:joola/src/pages/calendar.dart';
import 'package:joola/src/utils/utils.dart';

class LogActivity extends StatelessWidget {
  const LogActivity({
    super.key,
  });

  void log(BuildContext context, DateTime date) {
    int timestamp = DateTime.utc(date.year, date.month, date.day, 12).millisecondsSinceEpoch;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SettingsPopup(
          title: 'Log Activity',
          texts: const ['Activity', 'Duration (Minutes)'],
          obscures: const [false, false],
          keyboardTypes: const [TextInputType.text, TextInputType.number],
          action: (BuildContext context, List<TextEditingController> controllers) {
            try {
              final String activity = controllers.first.text;
              final int duration = int.parse(controllers.last.text);
              Utils.logActivity(activity, (duration / 60).floor(), timestamp);
              Navigator.pop(context);
              Utils.showErrorMessage(context, 'Logged activity');
            } catch (e) {
              Utils.showErrorMessage(context, e.toString());
            }
          }
        );
      }
    );
  }

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
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [CalendarPage(action: log),
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