import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class Utils {
  static double percentHeight(BuildContext context, double percent) {
    return MediaQuery.sizeOf(context).height * percent;
  }

  static double percentWidth(BuildContext context, double percent) {
    return MediaQuery.sizeOf(context).width * percent;
  }

  static void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message)
        );
      }
    );
  }
}