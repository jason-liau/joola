import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/pages/history.dart';
import 'package:joola/src/pages/settings.dart';
import '../utils/utils.dart';
import 'overview.dart';
import 'history.dart';

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
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Icon(Icons.settings_outlined,
              color: Colors.transparent, size: 30),
          ToggleBar(
            controller: controller,
          ),
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const SettingsPage();
                  }));
                },
                icon: const Icon(Icons.settings,
                    color: Color.fromARGB(255, 64, 64, 162), size: 30)),
          )
        ]),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: const [
              OverviewPage(),
              HistoryPage(),
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
              color: Colors.black12,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        padding: const EdgeInsets.all(2),
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
          borderRadius: BorderRadius.circular(13),
          selectedColor: const Color.fromARGB(255, 64, 64, 162),
          selectedBorderColor: Colors.white,
          tapTargetSize: MaterialTapTargetSize.padded,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: const Text(
                'Overview',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'calibri'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: const Text(
                'History',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'calibri'),
              ),
            ),
          ],
        ));
  }
}
