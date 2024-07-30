import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/components/day_circle.dart';
import 'package:joola/src/utils/utils.dart';

const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
int duration = 0;
int prevDuration = 0;
int prevPrevDuration = 0;
Map<String, bool> daysActive = {};
String uuidCache = '';

class DaysActive extends StatefulWidget {
  const DaysActive({
    super.key,
  });

  @override
  State<DaysActive> createState() => _DaysActiveState();
}

class _DaysActiveState extends State<DaysActive> {
  final String uuid = FirebaseAuth.instance.currentUser!.uid;

  String durationString(int duration) {
    duration = duration.abs();
    if (duration / Duration.secondsPerHour >= 1) {
      return '${formatDouble(duration / Duration.secondsPerHour)} hrs';
    }
    if (duration / Duration.secondsPerMinute >= 1) {
      return '${formatDouble(duration / Duration.secondsPerMinute)} mins';
    }
    return '0 mins';
  }

  String formatDouble(double d) {
    String formatted = d.toStringAsFixed(1);
    if (formatted.substring(formatted.length - 1) == '0') {
      return formatted.substring(0, formatted.length - 2);
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    if (uuid != uuidCache) {
      duration = 0;
      prevDuration = 0;
      prevPrevDuration = 0;
      daysActive = {};
      uuidCache = uuid;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('Activities').doc(uuid).collection('Week').doc(Utils.weekstamp(DateTime.now()).toString()).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data() != null) {
            final data = snapshot.data!.data()!;
            duration = 0;
            prevDuration = 0;
            prevPrevDuration = 0;
            daysActive = {};
            if (data.containsKey('duration')) {
              duration = data['duration'].round();
            }
            if (data.containsKey('previous_duration')) {
              prevDuration = data['previous_duration'].round();
            }
            if (data.containsKey('previous_previous_duration')) {
              prevPrevDuration = data['previous_previous_duration'].round();
            }
            if (data.containsKey('days_active')) {
              final days = data['days_active'];
              days.forEach((key, value) {
                daysActive[daysOfWeek[int.parse(key)]] = true;
              });
            }
          }
          return Container(
            decoration: const BoxDecoration(
              color: Colors.transparent
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(daysOfWeek.length, (int i) {
                      return DayCircle(day: daysOfWeek[i], check: daysActive[daysOfWeek[i]] ?? false);
                    })
                  ]
                ),
                const SizedBox(height: 15),
                const Divider(
                  color: Color.fromARGB(255, 107, 95, 185),
                  thickness: 2,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: '${durationString(duration)} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                              const TextSpan(text: 'Activity')
                            ]
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text('This Week', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (prevDuration - prevPrevDuration > 0)
                        Row(
                          children: [
                            Text('${durationString(prevDuration - prevPrevDuration).split(' ')[0]} ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xFFDFF20F))),
                            Stack(
                              children: [
                                const Icon(Icons.trending_up, color:Color(0xFFDFF20F)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 17, bottom: 4),
                                  child: Text(durationString(prevDuration - prevPrevDuration).split(' ')[1], style: const TextStyle(color: Color(0xFFDFF20F))),
                                ),
                              ]
                            )
                          ],
                        )
                        else if (prevDuration - prevPrevDuration < 0)
                        Row(
                          children: [
                            Text('${durationString(prevDuration - prevPrevDuration).split(' ')[0]} ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xffebb914))),
                            Stack(
                              children: [
                                const Icon(Icons.trending_down, color:Color(0xffebb914)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 17, bottom: 4),
                                  child: Text(durationString(prevDuration - prevPrevDuration).split(' ')[1], style: const TextStyle(color: Color(0xffebb914))),
                                ),
                              ]
                            )
                          ],
                        )
                        else
                        Row(
                          children: [
                            Text('${durationString(prevDuration - prevPrevDuration).split(' ')[0]} ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            Stack(
                              children: [
                                const Icon(Icons.trending_flat, color:Colors.white),
                                Padding(
                                  padding: const EdgeInsets.only(top: 17, bottom: 4),
                                  child: Text(durationString(prevDuration - prevPrevDuration).split(' ')[1], style: const TextStyle(color: Colors.white)),
                                ),
                              ]
                            )
                          ],
                        ),
                        const Text('vs Last Week', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      )
    );
  }
}