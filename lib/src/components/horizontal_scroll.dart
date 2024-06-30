import 'package:flutter/material.dart';

class HorizontalScroll extends StatelessWidget {
  const HorizontalScroll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 30
            ),
            child: Container(
              width: 240,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 158, 138, 230),
                borderRadius: BorderRadius.all(Radius.circular(20))
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30
            ),
            child: Container(
              width: 240,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 158, 138, 230),
                borderRadius: BorderRadius.all(Radius.circular(20))
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30
            ),
            child: Container(
              width: 240,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 158, 138, 230),
                borderRadius: BorderRadius.all(Radius.circular(20))
              )
            ),
          )
        ]
      ),
    );
  }
}