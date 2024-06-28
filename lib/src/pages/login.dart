import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:joola/src/components/login_button.dart';
import 'package:joola/src/components/login_text.dart';
import 'package:joola/src/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    // Loading
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator()
        );
      }
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException {
      if (mounted) {
        Navigator.of(context).pop();
      }
      showErrorMessage('Incorrect email or password');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message)
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
            
                // Logo
                const Icon(
                  Icons.lock,
                  size: 100
                ),
            
                const SizedBox(height: 50),
            
                // Welcome
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16
                  )
                ),
            
                const SizedBox(height: 25),
            
                // Email
                LoginText(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false
                ),
            
                const SizedBox(height: 10),
            
                // Password
                LoginText(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true
                ),
            
                const SizedBox(height: 10),
            
                // Forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.grey[600])
                      )
                    ]
                  )
                ),
            
                const SizedBox(height: 25),
            
                // Sign in
                LoginButton(
                  onTap: signIn,
                  text: 'Sign In'
                ),
            
                const SizedBox(height: 50),
            
                // Continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400]
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700])
                        )
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400]
                        )
                      )
                    ]
                  )
                ),
            
                const SizedBox(height: 50),
            
                // Google and Apple
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'assets/images/google.png'),
                    SizedBox(width: 25),
                    SquareTile(imagePath: 'assets/images/apple.png')
                  ]
                ),
            
                const SizedBox(height: 50),
            
                // Resgister
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700])
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    )
                  ]
                ),
              ]
            ),
          )
        )
      )
    );
  }
}
