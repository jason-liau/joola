import 'package:flutter/material.dart';

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
          height: 110,
          width: 180,
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
                size: 40
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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