import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/mood_checkin.dart';
import '../components/stats.dart';
import '../utils/utils.dart';

String name = '';

class OverviewPage extends StatefulWidget {
  static var padding = 0.02;
  // The padding for all elements on this page can be adjusted here (percentage).
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OverviewPage> {
  static var padding = OverviewPage.padding;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Stream<DocumentSnapshot> usersStream = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots();

  void editProfilePicture() {
    print('editted profile');
  }

  void checkIn() {
    print('checked in');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: usersStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          String firstName = data['first_name'] ?? '';
          String lastName = data['last_name'] ?? '';
          if (firstName != '' && lastName != '') {
            name = '$firstName $lastName';
          } else if (firstName != '') {
            name = firstName;
          } else if (lastName != '') {
            name = lastName;
          }
        }
        return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                    child: SizedBox(
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: Utils.percentHeight(context, padding)),
                              Center(
                                  child: Column(children: [
                                Stack(alignment: Alignment.bottomRight, children: [
                                  SizedBox(
                                      // color: Colors.red,
                                      width: Utils.percentWidth(context,
                                          0.18), // this needs to be double the avatar radius
                                      height: Utils.percentWidth(context, 0.18)),
                                  CircleAvatar(
                                      radius: Utils.percentWidth(context, 0.12)),
                                  Container(
                                      width: Utils.percentWidth(context, 0.07),
                                      height: Utils.percentWidth(context, 0.07),
                                      decoration: BoxDecoration(
                                        border: Border.fromBorderSide(BorderSide(
                                            color: Colors.white,
                                            width: Utils.percentWidth(
                                                context, 0.005))),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton.filled(
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        iconSize: Utils.percentWidth(context, 0.04),
                                        onPressed: editProfilePicture,
                                        icon: const Icon(Icons.edit),
                                      ))
                                ]),
                                SizedBox(
                                    height: Utils.percentHeight(context, padding)),
                                Text(name,
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold))
                              ])),
                              SizedBox(
                                  height: Utils.percentHeight(context, padding)),
                              const Text('Stats',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: Utils.percentHeight(context, padding)),
                              const Stats(),
                              SizedBox(
                                  height: Utils.percentHeight(context, padding)),
                              const Text('Mood Check-In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: Utils.percentHeight(context, padding)),
                              const MoodCheckIn(),
                              SizedBox(
                                  height: Utils.percentHeight(context, padding)),
                              // Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       const Text('Health Trends',
                              //           style: TextStyle(
                              //               color: Colors.black,
                              //               fontSize: 20,
                              //               fontWeight: FontWeight.bold)),
                              //       TextButton(
                              //           onPressed: checkIn,
                              //           child: const Text('+ Check In', style: const TextStyle(color: Colors.blue, fontSize: 16, )))
                              //     ]),
                            ])))));
      }
    );
  }
}
