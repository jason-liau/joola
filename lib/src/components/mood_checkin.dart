import 'package:flutter/material.dart';
import 'package:joola/src/utils/utils.dart';

class MoodCheckIn extends StatefulWidget {
  const MoodCheckIn({super.key});

  @override
  State<MoodCheckIn> createState() => _MoodCheckInState();
}

class _MoodCheckInState extends State<MoodCheckIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[350]!),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "How are you feeling today?",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: Utils.percentHeight(context, 0.02)),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(Icons.sentiment_very_dissatisfied),
                Text("Awful")
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(Icons.sentiment_very_dissatisfied),
                Text("Awful")
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(Icons.sentiment_very_dissatisfied),
                Text("Awful")
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(Icons.sentiment_very_dissatisfied),
                Text("Awful")
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(Icons.sentiment_very_dissatisfied),
                Text("Awful")
              ]),
            ])
          ])),
    );
  }
}
