import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  int index = 0;

  void _navigateToScreens(i) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: signOut, icon: const Icon(Icons.settings_outlined))]),
      bottomNavigationBar: Container(
        color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: BottomNavigationBar(
              showUnselectedLabels: false,
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              currentIndex: index,
              onTap: (int index) {
                setState(() {
                  this.index = index;
                });
                _navigateToScreens(index);
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(Icons.home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.sports_tennis_outlined,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(Icons.sports_tennis),
                  label: 'Train'
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(Icons.favorite),
                  label: 'Wellness'
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.feed_outlined,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(Icons.feed),
                  label: 'Services'
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(Icons.account_circle),
                  label: 'Profile'
                ),
              ]
            ),
          ),
        ),
    );
  }
}