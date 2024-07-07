import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:joola/src/components/duration_button.dart';
import 'package:joola/src/utils/utils.dart';

class DurationPage extends StatefulWidget {
  final IconData icon;
  final String text;

  const DurationPage({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  State<DurationPage> createState() => _DurationPage();
}

class _DurationPage extends State<DurationPage> {
  final Stopwatch stopwatch = Stopwatch();
  DateTime start = DateTime.now();
  String time = '00:00';
  int countdown = 5;

  String parseTime() {
    int duration = stopwatch.elapsed.inSeconds;
    String seconds = (duration % Duration.secondsPerMinute).toString().padLeft(2, "0");
    String minutes = (duration ~/ Duration.secondsPerMinute).toString().padLeft(2, "0");
    String hours = (duration ~/ Duration.secondsPerHour).toString();
    if (hours == '0') {
      return "$minutes:$seconds";
    }

    hours = hours.padLeft(2, "0");
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

  void countdownTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          countdown -= 1;
          if (countdown < 0) {
            startTimer();
            stopwatch.start();
            timer.cancel();
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  void endActivity(context) {
    try {
      int duration = stopwatch.elapsed.inSeconds;
      if (duration <= 0) {
        return;
      }
      int timestamp = start.millisecondsSinceEpoch;
      String activity = widget.text;
      Utils.logActivity(activity, duration, timestamp);
      Navigator.of(context)..pop()..pop();
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    countdownTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
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
              Column(
                children: [
                  Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 100
                  ),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      decoration: TextDecoration.none
                    )
                  ),
                ]
              ),
              if (countdown < 0)
              Column(
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
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
              )
              else
              Column(
                children: [
                  const Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Starting in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      )
                    ),
                  ),
                  Text(
                    countdown.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                    )
                  ),
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (countdown < 0)
                  DurationButton(
                    icon: Icons.stop_rounded,
                    color: const Color.fromARGB(255, 215, 88, 88),
                    onTap: () {
                      stopwatch.stop();
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Center(
                              child: SizedBox(
                                width: 380,
                                height: 350,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        widget.icon,
                                        color: const Color.fromARGB(255, 62, 62, 143),
                                        size: 100
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 40),
                                        child: Column(
                                          children: [
                                            Text(
                                              'End this workout?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                                fontFamily: 'calibri',
                                                fontWeight: FontWeight.w600,
                                                decoration: TextDecoration.none
                                              )
                                            ),
                                            Text(
                                              'This workout will be saved to your workout activity history.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'calibri',
                                                decoration: TextDecoration.none
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              stopwatch.start();
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 55,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 34, 34, 34),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: const Text(
                                                'Resume',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'calibri',
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration.none
                                                )
                                              )
                                            )
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              endActivity(context);
                                            },
                                            child: Container(
                                              height: 55,
                                              width: 150,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 215, 88, 88),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: const Text(
                                                'End Activity',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'calibri',
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration.none
                                                )
                                              )
                                            )
                                          )
                                        ]
                                      )
                                    ]
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      );
                    }
                  )
                  else
                  DurationButton(
                    icon: Icons.stop_rounded,
                    color: const Color.fromARGB(255, 215, 88, 88),
                    onTap: () {
                      stopwatch.stop();
                      Navigator.pop(context);
                    }
                  ),
                  if (countdown < 0 && stopwatch.isRunning)
                  DurationButton(
                    icon: Icons.pause,
                    color: const Color.fromARGB(255, 92, 107, 192),
                    onTap: () {
                      stopwatch.stop();
                    },
                  )
                  else if (countdown < 0)
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
        ),
      )
    );
  }
}