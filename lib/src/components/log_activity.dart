import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/components/home_button.dart';
import 'package:joola/src/components/settings_popup.dart';
import 'package:joola/src/pages/calendar.dart';
import 'package:joola/src/pages/history.dart';
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
          texts: const ['Activity', 'Duration'],
          obscures: const [false, false],
          keyboardTypes: const [TextInputType.text, TextInputType.number],
          action: (BuildContext context, List<TextEditingController> controllers) {
            try {
              String uuid = FirebaseAuth.instance.currentUser!.uid;
              final db = FirebaseFirestore.instance;
              final docRef = db.collection('Activities').doc(uuid);
              final String activity = controllers.first.text;
              final int duration = int.parse(controllers.last.text);
              docRef.set({'activities': FieldValue.arrayUnion([{'activity': activity, 'duration': duration, 'timestamp': timestamp}])}, SetOptions(merge: true));
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
              body: Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Stack(alignment: Alignment.bottomCenter, children: [
                        Column(children: [
                          CalendarPage(action: log),
                          SizedBox(height: Utils.percentHeight(context, .045))
                        ]),
                        const CalendarStreak(),
                      ])
                    ]),
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
                )),
            );
          })
        );
      }
    );
  }
}