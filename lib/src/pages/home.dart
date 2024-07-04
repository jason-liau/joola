import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/components/home_header.dart';
import 'package:joola/src/components/log_activity.dart';
import 'package:joola/src/components/start_activity.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String uuid = FirebaseAuth.instance.currentUser!.uid;

  Future<DocumentSnapshot<Object?>> documentSnapshot() async {
    final CollectionReference users = firestore.collection('Users');
    DocumentSnapshot<Object?> doc = await users.doc(uuid).get();
    return doc;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 64, 64, 162),
      body: FutureBuilder<DocumentSnapshot>(
        future: documentSnapshot(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            String? firstName;
            if (!(snapshot.hasError || (snapshot.hasData && !snapshot.data!.exists))) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              firstName = data['first_name'];
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
                  top: -50,
                  left: -200,
                  child: Container(
                    width: 500,
                    height: 500,
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
                  top: -20,
                  left: -230,
                  child: Container(
                    width: 500,
                    height: 500,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 60
                  ),
                  child: Text(
                      firstName == null || firstName.isEmpty ? 'Welcome!' : 'Welcome, $firstName!',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                DraggableScrollableSheet(
                  snap: true,
                  initialChildSize: 0.60,
                  minChildSize: 0.60,
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
          return const Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}