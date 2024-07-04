import 'package:flutter/material.dart';
import '../utils/utils.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        StatUnit(count: "5 hours", type: "Activity", icon: Icons.run_circle),
        StatUnit(
            count: "1 hr 3 min",
            type: "Mindful Minutes",
            icon: Icons.heat_pump_rounded)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        StatUnit(
            count: "0 hours",
            type: "Total Classes",
            icon: Icons.model_training_outlined),
        StatUnit(
            count: "1 min",
            type: "Injury Free",
            icon: Icons.shield_moon_outlined)
      ]),
    ]);
  }
}

// TODO: write some custom function that only bolds the integers passed in
class StatUnit extends StatelessWidget {
  final String count;
  final String type;
  final IconData icon;

  const StatUnit(
      {super.key, required this.count, required this.type, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
            width: Utils.percentWidth(context, 0.4),
            child: Row(children: [
              Icon(icon),
              SizedBox(width: Utils.percentWidth(context, 0.02)),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(count), Text(type)])
            ])));
  }
}
