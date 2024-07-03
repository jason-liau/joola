import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:joola/src/components/login_text.dart';
import 'package:joola/src/utils/utils.dart';

class SettingsPopup extends StatefulWidget {
  final List<String> texts;
  final List<Function?> actions;

  const SettingsPopup({
    super.key,
    required this.texts,
    required this.actions
  });

  @override
  State<SettingsPopup> createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List.filled(widget.texts.length, TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)
            ),
            const Text('Update Name'),
          ],
        ),
        content: Column(
          children: [
            LoginText(
              controller: controllers[0],
              hintText: widget.texts[0],
              obscureText: false
            )
          ]
        ),
      ),
    );
  }
}