import 'package:flutter/material.dart';
import 'package:joola/src/components/card_view.dart';
import 'package:joola/src/utils/utils.dart';

class WellnessPage extends StatelessWidget {
  const WellnessPage({
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
            const CardView(
              image: 'assets/images/wade_warren.png',
              title: 'Walk More - Live Longer!',
              name: 'Wade Warren',
              widthPercent: 1,
            ),
            const SizedBox(height: 30),
            const CardView(
              image: 'assets/images/kathryn_murphy.png',
              title: '9 Key Nutrients as We Age',
              name: 'Kathryn Murphy',
              widthPercent: 1,
            ),
            const SizedBox(height: 30),
            const CardView(
              image: 'assets/images/theresa_webb.png',
              title: 'Healthy Sleep Tips',
              name: 'Theresa Webb',
              widthPercent: 1,
            ),
            const SizedBox(height: 30),
            const CardView(
              image: 'assets/images/dianne_russell.jpg',
              title: 'Don\'t Let Allergies Slow You Down',
              name: 'Dianne Russell',
              widthPercent: 1,
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