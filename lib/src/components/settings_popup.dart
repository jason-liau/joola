import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:joola/src/components/login_text.dart';

class SettingsPopup extends StatefulWidget {
  final String title;
  final List<String> texts;
  final List<bool> obscures;
  final List<TextInputType> keyboardTypes;
  final Function(BuildContext, List<TextEditingController>) action;

  const SettingsPopup({
    super.key,
    required this.title,
    required this.texts,
    required this.obscures,
    required this.keyboardTypes,
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
              padding: const EdgeInsets.only(top: 30, left: 30, right: 20, bottom: 15),
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
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
                  keyboardType: widget.keyboardTypes[i],
                  obscureText: widget.obscures[i]
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 15, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 215, 88, 88)
                      ),
                      width: 140,
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.action(context, controllers);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 34, 34, 34)
                      ),
                      width: 140,
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
                  ),
                ],
              )
            ),
          ]
        ),
      ),
    );
  }
}