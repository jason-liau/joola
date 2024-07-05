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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: Utils.percentHeight(context, 0.02)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFFFFD0D0)),
                    child: const Icon(Icons.sentiment_very_dissatisfied_rounded,
                        size: 50, color: Color(0xFFEF5350))),
                const Text("Awful", style: TextStyle(color: Color(0xFFEF5350)))
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFFFFE9D4)),
                    child: const Icon(Icons.sentiment_dissatisfied_rounded,
                        size: 50, color: Color(0xFFFF8A65))),
                const Text("Bad", style: TextStyle(color: Color(0xFFFF8A65)))
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFFFFEFC0)),
                    child: const Icon(Icons.sentiment_neutral_rounded,
                        size: 50, color: Color(0xFFF0B31B))),
                const Text("Okay", style: TextStyle(color: Color(0xFFF0B31B)))
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFFDBF1FC)),
                    child: const Icon(Icons.sentiment_satisfied_rounded,
                        size: 50, color: Color(0xFF4FC3F7))),
                const Text("Good", style: TextStyle(color: Color(0xFF4FC3F7)))
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFFACEFAE)),
                    child: const Icon(Icons.sentiment_very_satisfied_rounded,
                        size: 50, color: Color(0xFF66BB6A))),
                const Text("Great", style: TextStyle(color: Color(0xFF66BB6A)))
              ]),
            ])
          ])),
    );
  }
}
