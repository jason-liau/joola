import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:joola/src/components/login_text.dart';

class SettingsPopup extends StatefulWidget {
  final List<String> texts;
  final List<bool> obscures;
  final Function(BuildContext, List<TextEditingController>) action;

  const SettingsPopup({
    super.key,
    required this.texts,
    required this.obscures,
    required this.action
  });

  @override
  State<SettingsPopup> createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  late List<TextEditingController> controllers = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.texts.length; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)
                  ),
                  const Text(
                    'Update Name',
                    style: TextStyle(
                      fontSize: 25,
                    )
                  ),
                ],
              ),
            ),
            ...List.generate(widget.texts.length, (int i) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: LoginText(
                  controller: controllers[i],
                  hintText: widget.texts[i],
                  obscureText: widget.obscures[i]
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 15),
              child: GestureDetector(
                onTap: () {
                  widget.action(context, controllers);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 34, 34, 34)
                  ),
                  width: 150,
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                )
              )
            ),
          ]
        ),
      ),
    );
  }
}