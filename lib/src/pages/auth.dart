import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/pages/login.dart';
import 'package:joola/src/pages/navigation.dart';
import 'package:joola/src/pages/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            return const NavigationPage();
          } else {
            if (showLoginPage) {
              return LoginPage(
                onTap: togglePages
              );
            } else {
              return RegisterPage(
                onTap: togglePages
              );
            }
          }
        }
      )
    );
  }
}