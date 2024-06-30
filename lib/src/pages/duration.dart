import 'dart:async';

import 'package:flutter/material.dart';
import 'package:joola/src/components/duration_button.dart';

class DurationPage extends StatefulWidget {
  const DurationPage({
    super.key
  });

  @override
  State<DurationPage> createState() => _DurationPage();
}

class _DurationPage extends State<DurationPage> {
  final Stopwatch stopwatch = Stopwatch();
  String time = '00:00:00';

  String parseTime() {
    var second = stopwatch.elapsed.inSeconds;
    String seconds = (second % 60).toString().padLeft(2, "0");
    String minutes = (second ~/ 60).toString().padLeft(2, "0");
    String hours = (second ~/ 3600).toString().padLeft(2, "0");
 
    return "$hours:$minutes:$seconds";
  }

  void startTimer() {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (mounted) {
        setState(() {
          time = parseTime();
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    stopwatch.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 19, 19, 80),
              Color.fromARGB(255, 10, 10, 28),
            ],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              children: [
                Icon(
                  Icons.sports_tennis,
                  color: Colors.white,
                  size: 100
                ),
                Text(
                  'Pickleball',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  )
                ),
              ]
            ),
            Column(
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    fontWeight: FontWeight.bold
                  )
                ),
                const Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Duration',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    )
                  ),
                ),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DurationButton(
                  icon: Icons.stop_rounded,
                  color: const Color.fromARGB(255, 215, 88, 88),
                  onTap: () {
                    stopwatch.stop();
                    Navigator.pop(context);
                  }
                ),
                if (stopwatch.isRunning)
                DurationButton(
                  icon: Icons.pause,
                  color: const Color.fromARGB(255, 92, 107, 192),
                  onTap: () {
                    stopwatch.stop();
                  },
                )
                else
                DurationButton(
                  icon: Icons.play_arrow,
                  color: const Color.fromARGB(255, 92, 107, 192),
                  onTap: () {
                    stopwatch.start();
                  },
                )
              ],
            )
          ],
        )
      )
    );
  }
}