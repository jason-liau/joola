import 'package:flutter/material.dart';
import 'package:joola/src/components/activity_button.dart';
import 'package:joola/src/components/home_button.dart';
import 'package:joola/src/components/home_header.dart';
import 'package:joola/src/pages/duration.dart';

class StartActivity extends StatelessWidget {
  const StartActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HomeButton(
      text: 'Start Activity',
      icon: Icons.directions_run,
      color: const Color.fromARGB(255, 108, 108, 193),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 250,
              width: double.infinity,
              child: Container(
                alignment: Alignment.topLeft,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const HomeHeader(
                      text: 'Choose Activity'
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ActivityButton(
                          text: 'Pickleball',
                          icon: Icons.sports_tennis,
                          color: Colors.deepPurple.shade300,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const DurationPage();
                              })
                            );
                          },
                        ),
                        ActivityButton(
                          text: 'Meditation',
                          icon: Icons.airline_seat_recline_extra,
                          color: Colors.deepPurple.shade300,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const DurationPage();
                              })
                            );
                          },
                        ),
                        ActivityButton(
                          text: 'Stretching',
                          icon: Icons.sports_gymnastics,
                          color: Colors.deepPurple.shade300,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const DurationPage();
                              })
                            );
                          },
                        )
                      ]
                    )
                  ]
                )
              )
            );
          }
        );
      }
    );
  }
}