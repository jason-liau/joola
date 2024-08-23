import 'package:flutter/material.dart';
import 'package:joola/src/components/card_view.dart';
import 'package:joola/src/components/page_title.dart';
import 'package:joola/src/components/train_tab.dart';
import 'package:joola/src/utils/utils.dart';

class TrainPage extends StatelessWidget {
  const TrainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            const PageTitle(
              text: 'Train',
            ),
            const SizedBox(height: 30),
            TrainTab(),
            const SizedBox(height: 30),
            const CardView(
              image: 'assets/images/dave_peter.png',
              title: 'Strategic Court Positioning',
              name: 'Dave Peter',
              widthPercent: 1,
              rating: '4.5',
              icon: Icons.watch_later_rounded,
              text: '30 min'
            ),
            const SizedBox(height: 30),
            const CardView(
              image: 'assets/images/darrell_steward.jpg',
              title: 'Third Shot Drop Shot',
              name: 'Darrel Steward',
              widthPercent: 1,
              rating: '4.1',
              icon: Icons.watch_later_rounded,
              text: '25 min'
            ),
            const SizedBox(height: 30),
            const CardView(
              image: 'assets/images/leslie_alexander.png',
              title: 'Serve & Score Intensive',
              name: 'Leslie Alexander',
              widthPercent: 1,
              rating: '4.5',
              icon: Icons.watch_later_rounded,
              text: '15 min'
            ),
            const SizedBox(height: 30),
            const CardView(
              image: 'assets/images/brooklyn_simmons.png',
              title: 'Rally Ready Playbook',
              name: 'Brooklyn Simmons',
              widthPercent: 1,
              rating: '4.5',
              icon: Icons.watch_later_rounded,
              text: '18 min'
            ),
            const SizedBox(height: 30),
            const CardView(
              image: 'assets/images/cameron_williamson.png',
              title: 'Paddle Playbook Clinic',
              name: 'Cameron Williamson',
              widthPercent: 1,
              rating: '4.5',
              icon: Icons.watch_later_rounded,
              text: '35 min'
            ),
            SizedBox(
              height: Utils.percentHeight(context, 0.1),
            )
          ]
        ),
      )
    );
  }
}