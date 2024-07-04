import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../components/mood_checkin.dart';
import '../components/stats.dart';
import '../utils/utils.dart';

class OverviewPage extends StatefulWidget {
  static var padding = 0.02;
  // The padding for all elements on this page can be adjusted here (percentage).
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OverviewPage> {
  static var padding = OverviewPage.padding;

  void editProfilePicture() {
    print('test');
  }

  void checkIn() {
    print('test');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
                child: Container(
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
                                  radius: Utils.percentWidth(context, 0.09)),
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
                            const Text("Jane Scott",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                          ])),
                          SizedBox(
                              height: Utils.percentHeight(context, padding)),
                          Stats(),
                          SizedBox(
                              height: Utils.percentHeight(context, padding)),
                          const Text('Mood Check-In',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                              height: Utils.percentHeight(context, padding)),
                          const MoodCheckIn(),
                          SizedBox(
                              height: Utils.percentHeight(context, padding)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Health Trends',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                TextButton(
                                    onPressed: checkIn,
                                    child: const Text('+ Check In', style: const TextStyle(color: Colors.blue, fontSize: 16, )))
                              ]),
                        ])))));
  }
}
