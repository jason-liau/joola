import 'package:flutter/material.dart';

class Utils {
  static DateTime weekStart = DateTime.utc(1);

  static double percentHeight(BuildContext context, double percent) {
    return MediaQuery.sizeOf(context).height * percent;
  }

  static double percentWidth(BuildContext context, double percent) {
    return MediaQuery.sizeOf(context).width * percent;
  }

  static void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message)
        );
      }
    );
  }

  static int monthstamp(DateTime date) {
    date = date.toUtc();
    return date.year * 12 + date.month;
  }

  static DateTime monthdate(int monthstamp) {
    double yearMonth = monthstamp / 12;
    if (monthstamp % 12 == 0) {
      int year = yearMonth.truncate() - 1;
      return DateTime.utc(year, 12);
    }
    
    int year = yearMonth.truncate();
    int month = monthstamp % 12;
    return DateTime.utc(year, month);
  }

  static DateTime monthdateFromDate(DateTime date) {
    return monthdate(monthstamp(date));
  }

  static int weekstamp(DateTime date) {
    date = date.toUtc();
    DateTime weekDate = date.subtract(Duration(days: date.weekday - 1));
    return (weekDate.difference(weekStart).inDays / 7).truncate();
  }

  static DateTime weekdate(int weekstamp) {
    return weekStart.add(Duration(days: weekstamp * 7));
  }

  static DateTime weekdateFromDate(DateTime date) {
    return weekdate(weekstamp(date));
  }
}