import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/utils/utils.dart';

class MoodCheckIn extends StatefulWidget {
  const MoodCheckIn({super.key});

  @override
  State<MoodCheckIn> createState() => _MoodCheckInState();
}

class _MoodCheckInState extends State<MoodCheckIn> with AutomaticKeepAliveClientMixin {
  int mood = 0;
  String uuidCache = '';
  final String uuid = FirebaseAuth.instance.currentUser!.uid;
  final Stream<DocumentSnapshot> moodStream = FirebaseFirestore.instance.collection('Moods').doc(FirebaseAuth.instance.currentUser!.uid).collection('Day').doc(Utils.daystamp(DateTime.now()).toString()).snapshots();

  // 1 - awful, 2 - bad, 3 - neutral, 4 - good, 5 - great
  void checkIn(int mood) {
    String uuid = FirebaseAuth.instance.currentUser!.uid;
    int daystamp = Utils.daystamp(DateTime.now());
    final docRef = FirebaseFirestore.instance.collection('Moods').doc(uuid).collection('Day').doc(daystamp.toString());
    docRef.set({'mood': mood}, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    if (uuidCache != uuid) {
      mood = 0;
      uuidCache = uuid;
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: moodStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          if (data.containsKey('mood')) {
            mood = data['mood'];
          }
        }

        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[350]!),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (mood == 0)
                Text(
                  "How are you feeling today?",
                  style: TextStyle(fontSize: Utils.percentWidth(context, 0.04), fontWeight: FontWeight.w500),
                )
                else
                Text(
                  "Checked in",
                  style: TextStyle(fontSize: Utils.percentWidth(context, 0.04), fontWeight: FontWeight.w500),
                ),
                if (mood == 0)
                SizedBox(height: Utils.percentHeight(context, 0.02)),
                if (mood == 0)
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    GestureDetector(
                      onTap: () {
                        checkIn(1);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle  ,
                              color: Color(0xFFFFD0D0)),
                          child: Icon(Icons.sentiment_very_dissatisfied_rounded,
                              size: Utils.percentWidth(context, 0.12), color: Color(0xFFEF5350))),
                    ),
                    const Text("Awful", style: TextStyle(color: Color(0xFFEF5350)))
                  ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    GestureDetector(
                      onTap: () {
                        checkIn(2);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFE9D4)),
                          child: Icon(Icons.sentiment_dissatisfied_rounded,
                              size: Utils.percentWidth(context, 0.12), color: Color(0xFFFF8A65))),
                    ),
                    const Text("Bad", style: TextStyle(color: Color(0xFFFF8A65)))
                  ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    GestureDetector(
                      onTap: () {
                        checkIn(3);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFEFC0)),
                          child: Icon(Icons.sentiment_neutral_rounded,
                              size: Utils.percentWidth(context, 0.12), color: Color(0xFFF0B31B))),
                    ),
                    const Text("Okay", style: TextStyle(color: Color(0xFFF0B31B)))
                  ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    GestureDetector(
                      onTap: () {
                        checkIn(4);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFDBF1FC)),
                          child: Icon(Icons.sentiment_satisfied_rounded,
                              size: Utils.percentWidth(context, 0.12), color: Color(0xFF4FC3F7))),
                    ),
                    const Text("Good", style: TextStyle(color: Color(0xFF4FC3F7)))
                  ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    GestureDetector(
                      onTap: () {
                        checkIn(5);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFACEFAE),
                              shape: BoxShape.circle),
                          child: Icon(Icons.sentiment_very_satisfied_rounded,
                              size: Utils.percentWidth(context, 0.12), color: Color(0xFF66BB6A))),
                    ),
                    const Text("Great", style: TextStyle(color: Color(0xFF66BB6A)))
                  ]),
                ])
              ])),
        );
      }
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
