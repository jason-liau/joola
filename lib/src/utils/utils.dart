import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Utils {
  static DateTime weekStart = DateTime(1).subtract(const Duration(days: 1));

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

  static int weekstamp(DateTime date) {
    DateTime weekDate = date.subtract(Duration(days: date.weekday % 7));
    return (weekDate.difference(weekStart).inDays / 7).truncate();
  }

  static DateTime weekdate(int weekstamp) {
    return weekStart.add(Duration(days: weekstamp * 7));
  }

  static void logActivity(String activity, int duration, int timestamp) {
    String uuid = FirebaseAuth.instance.currentUser!.uid;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    int week = weekstamp(date);
    final db = FirebaseFirestore.instance;
    final docRef = db.collection('Activities').doc(uuid);
    final weekDocRef = db.collection('Activities').doc(uuid).collection('Week').doc(week.toString());
    final nextWeekDocRef = db.collection('Activities').doc(uuid).collection('Week').doc((week + 1).toString());
    final nextNextWeekDocRef = db.collection('Activities').doc(uuid).collection('Week').doc((week + 2).toString());
    docRef.set({'activities': FieldValue.arrayUnion([{'activity': activity, 'duration': duration, 'timestamp': timestamp}])}, SetOptions(merge: true));
    weekDocRef.set({'duration': FieldValue.increment(duration), 'days_active': {(date.weekday % 7).toString(): FieldValue.increment(1)}}, SetOptions(merge: true));
    nextWeekDocRef.set({'previous_duration': FieldValue.increment(duration)}, SetOptions(merge: true));
    nextNextWeekDocRef.set({'previous_previous_duration': FieldValue.increment(duration)}, SetOptions(merge: true));
  }
}