import 'package:flutter/material.dart';
import 'calendar.dart';
import '../utils/utils.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(35),
        child: Column(children: [
          Stack(alignment: Alignment.bottomCenter, children: [
            Column(children: [
              CalendarPage(),
              SizedBox(height: Utils.percentHeight(context, .045))
            ]),
            const CalendarStreak(),
          ])
        ]));
  }
}

// About the displacement of CalendarStreak:
// 1) The extra padding within the table is in calendarStyle > tablePadding
// 2) The height of CalendarStreak is in Container > height
// 3) The difference between the bottom of CalendarStreak and the bottom of Calendar is 
// in the class HistoryPage, in the SizedBox right below CalendarPage
class CalendarStreak extends StatelessWidget {
  const CalendarStreak({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Utils.percentHeight(context, .09),
        width: Utils.percentWidth(context, .7),
        decoration: BoxDecoration(
            color: const Color(0xFF222222), borderRadius: BorderRadius.circular(16)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Streak(number: "19 Days", unit: "Active"),
          Streak(number: "12 Days", unit: "Longest Streak"),
          Streak(number: "4 Week", unit: "Streak"),
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
