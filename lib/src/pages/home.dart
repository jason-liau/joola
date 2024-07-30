import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/components/days_active.dart';
import 'package:joola/src/components/home_header.dart';
import 'package:joola/src/components/log_activity.dart';
import 'package:joola/src/components/progress_bar.dart';
import 'package:joola/src/components/start_activity.dart';
import 'package:joola/src/utils/utils.dart';

String firstName = '';
String uuidCache = '';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String uuid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    if (uuidCache != uuid) {
      firstName = '';
      uuidCache = uuid;
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 64, 64, 162),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('Users').doc(uuid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data();
            if (data != null) {
              firstName = data['first_name'] ?? '';
            }
          }
          return Stack(
            children: [
              FractionallySizedBox(
                heightFactor: 0.42,
                widthFactor: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 64, 64, 162),
                        Color.fromARGB(255, 121, 106, 199),
                      ],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                )
              ),
              Positioned(
                top: -Utils.percentWidth(context, 0.1),
                left: -Utils.percentWidth(context, 0.45),
                child: Container(
                  width: Utils.percentWidth(context, 1.12),
                  height: Utils.percentWidth(context, 1.12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 80, 78, 171),
                        Color.fromARGB(255, 107, 97, 189),
                        Color.fromARGB(255, 138, 120, 208),
                      ],
                      tileMode: TileMode.clamp,
                    ),
                    shape: BoxShape.circle
                  )
                ),
              ),
              Positioned(
                top: -Utils.percentWidth(context, 0.035),
                left: -Utils.percentWidth(context, 0.515),
                child: Container(
                  width: Utils.percentWidth(context, 1.12),
                  height: Utils.percentWidth(context, 1.12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 97, 93, 180),
                        Color.fromARGB(255, 162, 141, 222),
                      ],
                      tileMode: TileMode.clamp,
                    ),
                    shape: BoxShape.circle
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: MediaQuery.of(context).viewPadding.top + 10,
                ),
                child: Builder(builder: (context) {
                  return firstName == '' ? RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Welcome!')
                      ]
                    ),
                  ) : RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'Welcome, '),
                        TextSpan(text: '$firstName!', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ]
                    ),
                  );
                })
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).viewPadding.top + 10 + Utils.percentWidth(context, 0.2)),
                child: const ProgressBar(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: MediaQuery.of(context).viewPadding.top + 10 + Utils.percentWidth(context, 0.21)),
                decoration: const BoxDecoration(
                  color: Colors.transparent
                ),
                child: const DaysActive()
              ),
              DraggableScrollableSheet(
                snap: true,
                initialChildSize: 1 - (Utils.percentWidth(context, 0.7) + MediaQuery.of(context).viewPadding.top + 10) / MediaQuery.sizeOf(context).height,
                minChildSize: 1 - (Utils.percentWidth(context, 0.7) + MediaQuery.of(context).viewPadding.top + 10) / MediaQuery.sizeOf(context).height,
                maxChildSize: 1,
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                      color: Colors.white
                    ),
                    child: SingleChildScrollView(
                      physics: const ScrollPhysics(
                        parent: BouncingScrollPhysics()
                      ),
                      controller: scrollController,
                      child: const Column(
                        children: [
                          // HomeHeader(
                          //   text: 'In Progress'
                          // ),
                          // HorizontalScroll(),
                          HomeHeader(
                            text: 'Activity'
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StartActivity(),
                              LogActivity()
                            ]
                          ),
                          // HomeHeader(
                          //   text: 'Recommended for You'
                          // ),
                          // HorizontalScroll(),
                          // HomeHeader(
                          //   text: 'Train'
                          // ),
                          // HorizontalScroll(),
                          // HomeHeader(
                          //   text: 'Trending Categories'
                          // ),
                          // HorizontalScroll(),
                          // HomeHeader(
                          //   text: 'Upcoming Events'
                          // ),
                          // HorizontalScroll(),
                          Padding(padding: EdgeInsets.only(bottom: 30))
                        ]
                      )
                    )
                  );
                }
              )
            ]
          );
        }
      )
    );
  }
}