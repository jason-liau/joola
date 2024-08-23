import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/utils/utils.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key,
  });

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> with AutomaticKeepAliveClientMixin{
  final String uuid = FirebaseAuth.instance.currentUser!.uid;
  int duration = 0;
  String uuidCache = '';

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
            if (data.containsKey('duration')) {
              duration = data['duration'].round();
            }
          }
          return Container(
            decoration: const BoxDecoration(
              color: Colors.transparent
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: Color(0xFFDFF20F),
                ),
                width: Utils.percentWidth(context, min(duration / (150 * 60), 1)),
                height: Utils.percentWidth(context, 0.05)
              ),
            )
          );
        }
      )
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}