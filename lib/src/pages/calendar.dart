import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/utils.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    super.key,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  void prevMonth() {}

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.0),
          borderRadius: BorderRadius.circular(12)),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.now(),
        focusedDay: _focusedDay,
        currentDay: _focusedDay,
        calendarFormat: CalendarFormat.month,
        availableCalendarFormats: const {CalendarFormat.month: 'Month'},
        sixWeekMonthsEnforced: false,
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (BuildContext context, DateTime date) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Monthly Activity',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Row(children: [
                  GestureDetector(
                      onTap: prevMonth, child: Chevron(isRight: false)),
                  Text(
                    [
                      'January',
                      'February',
                      'March',
                      'April',
                      'May',
                      'June',
                      'July',
                      'August',
                      'September',
                      'October',
                      'November',
                      'December'
                    ][date.month - 1],
                    style: const TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                        });
                      },
                      child: Chevron(
                        isRight: true,
                      ))
                ])
              ],
            );
          },
        ),
        calendarStyle: CalendarStyle(
            todayDecoration: const BoxDecoration(color: Colors.green),
            markerDecoration: const BoxDecoration(color: Colors.green),
            tablePadding:
                EdgeInsets.only(bottom: Utils.percentHeight(context, 0.045))),
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
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)))),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        daysOfWeekHeight: 40,
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: const TextStyle(fontWeight: FontWeight.bold),
            weekendStyle: const TextStyle(fontWeight: FontWeight.bold),
            dowTextFormatter: (date, locale) {
              return ['M', 'T', 'W', 'T', 'F', 'S', 'S'][date.weekday - 1];
            }),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
      ),
    ));
  }
}

class Chevron extends StatelessWidget {
  Chevron({super.key, this.isRight = true});

  bool isRight;

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
                color: Colors.black, shape: BoxShape.circle),
            child: Icon(isRight ? Icons.chevron_right : Icons.chevron_left,
                color: Colors.white, size: Utils.percentWidth(context, 0.04))));
  }
}
