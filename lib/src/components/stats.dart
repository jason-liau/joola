import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Utils.percentHeight(context, 0.25),
      child: const Column(mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          StatUnit(
            count: "5 hrs",
            type: "Activity",
            icon: Icons.run_circle_rounded,
            topColor: Color(0xFFF68216),
            botColor: Color(0xFFFFB979)
          ),
          StatUnit(
            count: "1 hr & 12 min",
            type: "Mindful Minutes",
            icon: CupertinoIcons.heart_fill,
            topColor: Color(0xFFBF4C78),
            botColor: Color(0xFFE98AB1)
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          StatUnit(
            count: "102",
            type: "Total Classes",
            icon: Icons.play_circle_rounded,
            topColor: Color(0xFF138950),
            botColor: Color(0xFF28C180)
          ),
          StatUnit(
            count: "40 days",
            type: "Injury Free",
            icon: Icons.health_and_safety_rounded,
            topColor: Color(0xFF4298A4),
            botColor: Color(0xFF59BFCE)
          )
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          StatUnit(
            count: "60 days",
            type: "Joined JOOLA",
            icon: Icons.access_time_filled_rounded,
            topColor: Color(0xFF4242A4),
            botColor: Color(0xFF8585DF)
          ),
          StatUnit(
            count: "24 days",
            type: "Longest Streak",
            icon: Icons.local_fire_department,
            topColor: Color(0xFFFF6261),
            botColor: Color(0xFFFFA46F)
          )
        ]),
      ]),
    );
  }
}

class StatUnit extends StatelessWidget {
  final String count;
  final String type;
  final IconData icon;
  final Color topColor;
  final Color botColor;

  const StatUnit(
    {super.key, required this.count, required this.type, required this.icon, this.topColor = Colors.black, this.botColor = Colors.black}
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
            width: Utils.percentWidth(context, 0.4),
            child: Row(children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [topColor, botColor],
                ).createShader(bounds),
                child: Icon(
                  icon,
                  size: 40,
                ),
              ),
              SizedBox(width: Utils.percentWidth(context, 0.02)),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldStatCount(count: count),
                    Text(type)]
                  )
            ])));
  }
}

class BoldStatCount extends StatelessWidget {
  final String count;

  const BoldStatCount({super.key, required this.count});

  bool isNumeric(String s) {
    try {
      double.parse(s);
      return true;
    } on FormatException {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final splitted = count.split(' ');

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        children: <TextSpan>[
          ...List.generate(splitted.length, (int i) {
            var separator = ' ';
            if (i == splitted.length - 1) {
              separator = '';
            }

            final t = splitted[i];
            if (isNumeric(t)) {
              return TextSpan(text: t + separator, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black));
            }
            
            return TextSpan(text: t + separator, style: const TextStyle(fontSize: 20, color: Colors.black));
          })
        ]
      ),
    );
  }
}
