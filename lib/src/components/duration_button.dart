import 'package:flutter/material.dart';

class DurationButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function()? onTap;

  const DurationButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      height: 110,
      width: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: 
        Icon(
          icon,
          color: Colors.white,
          size: 60
        )
      )
    );
  }
}