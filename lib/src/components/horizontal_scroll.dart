import 'package:flutter/material.dart';
import 'package:joola/src/utils/utils.dart';

class HorizontalScroll extends StatelessWidget {
  final List<Widget> widgets;

  const HorizontalScroll({
    super.key,
    required this.widgets
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Utils.percentWidth(context, 0.6),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: widgets
      ),
    );
  }
}