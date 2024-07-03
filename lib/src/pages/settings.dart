import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/components/account_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  Future<void> _signOut(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: const Color.fromARGB(255, 66, 66, 164),
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            const AccountSettings(),
            GestureDetector(
              onTap: () {
                _signOut(context);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFFFFEBEE)
                ),
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFFDF3B3B),
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              )
            )
          ],
        ), 
      ),
    );
  }
}