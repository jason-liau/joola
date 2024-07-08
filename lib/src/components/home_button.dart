import 'package:flutter/material.dart';
import 'package:joola/src/utils/utils.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Function()? onTap;

  const HomeButton({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: Utils.percentWidth(context, 0.25),
          width: Utils.percentWidth(context, 0.4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: Utils.percentWidth(context, 0.1),
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Utils.percentWidth(context, 0.045),
                  fontWeight: FontWeight.bold
                )
              ),
            ]
          )
        ),
      )
    );
  }
}