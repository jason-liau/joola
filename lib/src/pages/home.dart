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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: signOut, icon: const Icon(Icons.settings_outlined))]),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5
          ),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.grey.shade600,
            activeColor: Colors.white,
            gap: 8,
            onTabChange: (index) {
            },
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home'
              ),
              GButton(
                icon: Icons.sports_tennis_outlined,
                text: 'Train'
              ),
              GButton(
                icon: Icons.favorite_border_outlined,
                text: 'Welness'
              ),
              GButton(
                icon: Icons.feed_outlined,
                text: 'Services'
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                text: 'Profile'
              ),
            ]
          ),
        ),
      )
    );
  }
}