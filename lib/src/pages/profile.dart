import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PageController controller = PageController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: Utils.percentHeight(context, .1),
        // ),
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Icon(Icons.settings, color: Colors.transparent),
          ToggleBar(
            controller: controller,
          ),
          IconButton(onPressed: signOut, icon: const Icon(Icons.settings))
        ]),
        Expanded(
          child: PageView(
            controller: controller,
            children: [
              Column(
                children: [Text("profile")],
              ),
              Column(
                children: [Text("history")],
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class ToggleBar extends StatefulWidget {
  final PageController controller;
  const ToggleBar({super.key, required this.controller});

  @override
  State<ToggleBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ToggleBar> {
  List<bool> isSelected = [true, false];
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        padding: EdgeInsets.all(Utils.percentHeight(context, 0.005)),
        child: ToggleButtons(
          onPressed: (int index) {
            setState(() {
              if (index == 1) {
                _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              } else {
                _controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              }
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == index;
              }
            });
          },
          isSelected: isSelected,
          renderBorder: false,
          borderRadius: BorderRadius.circular(12),
          children: <Widget>[
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                'Overview',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                'History',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ));
  }
}
