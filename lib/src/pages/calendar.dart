import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.now(),
              focusedDay: _focusedDay,
              currentDay: _focusedDay,
              availableCalendarFormats: const {CalendarFormat.month : 'Month'},
              sixWeekMonthsEnforced: true,
              calendarBuilders: CalendarBuilders(
                headerTitleBuilder: (BuildContext context, DateTime date) {
                  return Row(
                    children: [
                      const Text('Log Activity'),
                      Text('${date.month} ${date.year}')
                    ],
                  );
                },
              ),
              calendarStyle: const CalendarStyle(
                isTodayHighlighted: false
              ),
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),

              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: GestureDetector(
                child: const InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      )
                    ),
                  ),
                ),
                onTap: () {
                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
              ),
            )
          ],
        )
      )
    );
  }
}