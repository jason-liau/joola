import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/utils.dart';

Map<String, bool> activeDays = {}; // y-m-d -> isActive
Map<String, int> monthlyDaysActive = {}; // y-m -> daysActive
Map<String, int> longestStreak = {}; // y-m -> streak
int streak = 0;

class CalendarPage extends StatefulWidget {
  final Function(BuildContext, DateTime)? action;
  final Duration pageAnimationDuration;
  final Curve pageAnimationCurve;

  const CalendarPage({
    super.key,
    this.action,
    this.pageAnimationDuration = const Duration(milliseconds: 200),
    this.pageAnimationCurve = Curves.easeOut,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Stream<DocumentSnapshot> activityStream = FirebaseFirestore.instance.collection('Activities').doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
  late PageController _pageController;
  DateTime current = DateTime.now();

  void _onLeftChevronTap() {
    _pageController.previousPage(
      duration: widget.pageAnimationDuration,
      curve: widget.pageAnimationCurve,
    );
  }

  void _onRightChevronTap() {
    _pageController.nextPage(
      duration: widget.pageAnimationDuration,
      curve: widget.pageAnimationCurve,
    );
  }

  bool active(DateTime date) {
    return activeDays[dateKey(date)] ?? false;
  }

  String dateKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  String monthKey(DateTime date) {
    return '${date.year}-${date.month}';
  }

  int getLongestStreak(DateTime date) {
    String month = monthKey(date);
    if (longestStreak.containsKey(month)) {
      return longestStreak[month] ?? 0;
    }

    int streak = 0;
    int maxStreak = 0;

    for (int i = 1; i <= 31; i++) {
      String key = '${date.year}-${date.month}-$i';
      bool active = activeDays[key] ?? false;
      if (active) {
        streak += 1;
      } else {
        streak = 0;
      }
      if (streak > maxStreak) {
        maxStreak = streak;
      }
    }

    longestStreak[month] = maxStreak;
    return maxStreak;
  }

  int getStreak() {
    if (streak > 0) {
      return streak;
    }
    DateTime date = DateTime.now();
    if (activeDays[dateKey(date)] ?? false) {
      streak = 1;
    }
    date = date.subtract(const Duration(days: 1));
    while (activeDays[dateKey(date)] ?? false) {
      streak += 1;
      date = date.subtract(const Duration(days: 1));
    }
    return streak;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: activityStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          if (data.containsKey('activities')) {
            var activities = data['activities'];
            activeDays = {};
            monthlyDaysActive = {};
            longestStreak = {};
            streak = 0;
            for (Map<String, dynamic> activity in activities) {
              var timestamp = activity['timestamp'];
              DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
              if (!(activeDays[dateKey(date)] ?? false)) {
                monthlyDaysActive[monthKey(date)] = (monthlyDaysActive[monthKey(date)] ?? 0) + 1;
              }
              activeDays[dateKey(date)] = true;
            }
          }
        }

        return Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            children: [
              Stack(
                children: [Column(
                  children: [
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.0),
                          borderRadius: BorderRadius.circular(12)),
                      child: TableCalendar(
                        onPageChanged: (DateTime date) {
                          setState(() {
                            current = date;
                          });
                        },
                        onCalendarCreated: (pageController) {
                          _pageController = pageController;
                        },
                        firstDay: DateTime(1970, 1, 1),
                        lastDay: DateTime.now(),
                        focusedDay: current,
                        currentDay: DateTime.now(),
                        calendarFormat: CalendarFormat.month,
                        sixWeekMonthsEnforced: true,
                        availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                        calendarBuilders: CalendarBuilders(
                          headerTitleBuilder: (BuildContext context, DateTime date) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Monthly Activity',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                SizedBox(width: Utils.percentWidth(context, 0.05)),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    GestureDetector(
                                        onTap: _onLeftChevronTap, child: Chevron(isRight: false)),
                                    Text(
                                      DateFormat.MMMM().format(date),
                                      style: const TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                    GestureDetector(
                                        onTap: _onRightChevronTap,
                                        child: Chevron(
                                          isRight: true,
                                        ))
                                  ]),
                                )
                              ],
                            );
                          },
                          selectedBuilder: (BuildContext context, DateTime firstDate, DateTime secondDate) {
                            return Padding(
                              padding: const EdgeInsets.all(6),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  firstDate.day.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  )
                                )
                              ),
                            );
                          }
                        ),
                        calendarStyle: CalendarStyle(
                          weekendTextStyle: const TextStyle(
                            fontSize: 17
                          ),
                          outsideTextStyle: const TextStyle(
                            fontSize: 17,
                            color: Colors.black26
                          ),
                          disabledTextStyle: const TextStyle(
                            fontSize: 17,
                            color: Colors.black12
                          ),
                          defaultTextStyle: const TextStyle(
                            fontSize: 17
                          ),
                          todayTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFAFEE7),
                            border: Border.all(
                              color: Colors.green,
                              width: 3
                            )
                          ),
                          markerDecoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                          tablePadding:
                              EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10 + Utils.percentHeight(context, 0.045))),
                        headerStyle: HeaderStyle(
                            headerPadding: EdgeInsets.fromLTRB(
                                Utils.percentWidth(context, 0.05),
                                Utils.percentHeight(context, 0.015),
                                Utils.percentWidth(context, 0.02),
                                Utils.percentHeight(context, 0.015)),
                            headerMargin:
                                EdgeInsets.only(bottom: Utils.percentHeight(context, 0.01)),
                            leftChevronVisible: false,
                            rightChevronVisible: false,
                            titleCentered: true,
                            formatButtonVisible: false,
                            decoration: const BoxDecoration(
                                color: Color(0xFF222222),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)))),
                        selectedDayPredicate: (date) {
                          return active(date);
                        },
                        daysOfWeekHeight: 40,
                        daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            weekendStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            dowTextFormatter: (date, locale) {
                              return ['M', 'T', 'W', 'T', 'F', 'S', 'S'][date.weekday - 1];
                            }),
                        onDaySelected: (selectedDay, focusedDay) {
                          if (widget.action == null) {
                            return;
                          }
                    
                          widget.action!(context, selectedDay);
                        },
                      ),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 440),
                  child: Center(child: CalendarStreak(active: monthlyDaysActive[monthKey(current)] ?? 0, longestStreak: getLongestStreak(current), streak: getStreak())),
                ),
                ]
              ),
            ],
          ),
        );
      }
    );
  }
}

class Chevron extends StatelessWidget {
  const Chevron({super.key, this.isRight = true});

  final bool isRight;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.symmetric(horizontal: Utils.percentWidth(context, 0.02)),
        padding: const EdgeInsets.all(1.5),
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFF222222), shape: BoxShape.circle),
            child: Icon(isRight ? Icons.chevron_right : Icons.chevron_left,
                color: Colors.white, size: Utils.percentWidth(context, 0.04))));
  }
}

// About the displacement of CalendarStreak:
// 1) The extra padding within the table is in calendarStyle > tablePadding
// 2) The height of CalendarStreak is in Container > height
// 3) The difference between the bottom of CalendarStreak and the bottom of Calendar is 
// in the class HistoryPage, in the SizedBox right below CalendarPage
class CalendarStreak extends StatelessWidget {
  final int active;
  final int longestStreak;
  final int streak;

  const CalendarStreak({super.key, this.active = 0, this.longestStreak = 0, this.streak = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Utils.percentHeight(context, .09),
        width: Utils.percentWidth(context, .7),
        decoration: BoxDecoration(
            color: const Color(0xFF222222), borderRadius: BorderRadius.circular(16)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(child: Streak(number: "$active ${active == 1 ? 'Day' : 'Days'}", unit: "Active")),
          Expanded(child: Streak(number: "$longestStreak ${longestStreak == 1 ? 'Day' : 'Days'}", unit: "Longest Streak")),
          Expanded(child: Streak(number: "$streak ${streak == 1 ? 'Day' : 'Days'}", unit: "Streak")),
        ]));
  }
}

class Streak extends StatelessWidget {
  Streak({Key? key, required this.number, required this.unit}) : super(key: key);
  
  final String number;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(number,
          style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.lime)),
      Text(unit,
          style:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white))
    ]);
  }
}

