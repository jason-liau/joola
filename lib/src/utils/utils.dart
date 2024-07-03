import 'package:flutter/material.dart';

class Utils {
  static double percentHeight(BuildContext context, double percent) {
    return MediaQuery.sizeOf(context).height * percent;
  }

  static double percentWidth(BuildContext context, double percent) {
    return MediaQuery.sizeOf(context).width * percent;
  }
}