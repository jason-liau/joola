import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/pages/home.dart';
import 'package:joola/src/pages/profile.dart';
import 'package:joola/src/pages/services.dart';
import 'package:joola/src/pages/train.dart';
import 'package:joola/src/pages/wellness.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPage();
}

class _NavigationPage extends State<NavigationPage> {
  final user = FirebaseAuth.instance.currentUser;
  final List<Widget> pages = [
    HomePage(),
    const TrainPage(),
    const WellnessPage(),
    const ServicesPage(),
    const ProfilePage()
  ];

  int pageIndex = 0;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              showUnselectedLabels: false,
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              currentIndex: pageIndex,
              onTap: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.grey
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: Colors.white
                  ),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.sports_tennis_outlined,
                    color: Colors.grey
                  ),
                  activeIcon: Icon(
                    Icons.sports_tennis,
                    color: Colors.white
                  ),
                  label: 'Train'
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey
                  ),
                  activeIcon: Icon(
                    Icons.favorite,
                    color: Colors.white
                  ),
                  label: 'Wellness'
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.feed_outlined,
                    color: Colors.grey
                  ),
                  activeIcon: Icon(
                    Icons.feed,
                    color: Colors.white
                  ),
                  label: 'Services'
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.grey
                  ),
                  activeIcon: Icon(
                    Icons.account_circle,
                    color: Colors.white
                  ),
                  label: 'Profile'
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}