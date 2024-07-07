import 'package:flutter/material.dart';

class DayCircle extends StatelessWidget {
  final String day;
  final bool check;

  const DayCircle({
    super.key,
    required this.day,
    required this.check
  });

  @override
  Widget build(BuildContext context) {
    if (check) {
      return Column(
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFDFF20F),
              // border: Border.all(color: Colors.white)
            ),
            child: const Icon(Icons.check_rounded, color: Color(0xFF6565C3), size: 25)
          ),
          const SizedBox(height: 10),
          Text(day, style: const TextStyle(color: Color(0xFFDFF20F), fontWeight: FontWeight.bold))
        ]
      );
    }
    return Column(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: Colors.white)
          ),
        ),
        const SizedBox(height: 10),
        Text(day, style: const TextStyle(color: Colors.white))
      ]
    );
  }
}