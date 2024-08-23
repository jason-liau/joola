import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/components/card_view.dart';
import 'package:joola/src/components/days_active.dart';
import 'package:joola/src/components/home_header.dart';
import 'package:joola/src/components/horizontal_scroll.dart';
import 'package:joola/src/components/log_activity.dart';
import 'package:joola/src/components/progress_bar.dart';
import 'package:joola/src/components/start_activity.dart';
import 'package:joola/src/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final String uuid = FirebaseAuth.instance.currentUser!.uid;
  String firstName = '';
  String uuidCache = '';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    image: DecorationImage(
                      image: AssetImage('assets/images/home_background.png'),
                      fit: BoxFit.cover
                    ),
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
                      child: Column(
                        children: [
                          // HomeHeader(
                          //   text: 'In Progress'
                          // ),
                          // HorizontalScroll(),
                          const SizedBox(height: 30),
                          const HomeHeader(
                            text: 'Activity'
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StartActivity(),
                              LogActivity()
                            ]
                          ),
                          const SizedBox(height: 30),
                          const HomeHeader(
                            text: 'Recommended for You'
                          ),
                          const SizedBox(height: 30),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: HorizontalScroll(
                              widgets: <Widget>[
                                CardView(
                                  image: 'assets/images/ronald_richards.jpg',
                                  title: 'Breath Awareness Techniques',
                                  name: 'Ronald Richards',
                                  widthPercent: 0.7,
                                  rating: '4.5',
                                  icon: Icons.menu_book_outlined,
                                  text: '30 Classes'
                                ),
                                SizedBox(width: 30),
                                CardView(
                                  image: 'assets/images/devon_lane.jpg',
                                  title: 'Changing Spin on Serve',
                                  name: 'Devon Lane',
                                  widthPercent: 0.7,
                                  rating: '4.5',
                                  icon: Icons.watch_later_rounded,
                                  text: '30 min'
                                ),
                                SizedBox(width: 30),
                                CardView(
                                  image: 'assets/images/jenny_wilson.jpg',
                                  title: 'Inner Calm Stretches',
                                  name: 'Jenny Wilson',
                                  widthPercent: 0.7,
                                  rating: '4.1',
                                  icon: Icons.watch_later_rounded,
                                  text: '12 Classes'
                                )
                              ]
                            ),
                          ),
                          // HomeHeader(
                          //   text: 'Train'
                          // ),
                          // HorizontalScroll(),

                          const SizedBox(height: 30),
                          const HomeHeader(
                            text: 'Trending Categories'
                          ),
                          const SizedBox(height: 30),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: HorizontalScroll(
                              widgets: <Widget>[
                                CardView(
                                  image: 'assets/images/robert_fox.png',
                                  title: 'Paddle Play Warmup',
                                  name: 'Robert Fox',
                                  widthPercent: 0.7,
                                  rating: '4.5',
                                  icon: Icons.watch_later_rounded,
                                  text: '30 min'
                                ),
                                SizedBox(width: 30),
                                CardView(
                                  image: 'assets/images/brian_howard.jpg',
                                  title: 'Tranquil Touch Session',
                                  name: 'Brian Howard',
                                  widthPercent: 0.7,
                                  rating: '4.3',
                                  icon: Icons.watch_later_rounded,
                                  text: '45 min'
                                ),
                                SizedBox(width: 30),
                                CardView(
                                  image: 'assets/images/albert_flores.png',
                                  title: 'Stretch & Strengthen Session',
                                  name: 'Albert Flores',
                                  widthPercent: 0.7,
                                  rating: '4.5',
                                  icon: Icons.watch_later_rounded,
                                  text: '25 min'
                                )
                              ]
                            ),
                          ),
                          // HomeHeader(
                          //   text: 'Upcoming Events'
                          // ),
                          // HorizontalScroll(),
                          SizedBox(height: Utils.percentWidth(context, 0.2)),
                          const Padding(padding: EdgeInsets.only(bottom: 30))
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