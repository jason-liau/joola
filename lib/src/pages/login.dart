import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:joola/src/components/login_button.dart';
import 'package:joola/src/components/login_text.dart';
import 'package:joola/src/components/square_tile.dart';
import 'package:joola/src/utils/utils.dart';

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
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      Utils.showErrorMessage(context, e.code);
    }
  }

  void resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      Utils.showErrorMessage(context, 'Sent email to reset password');
    } on FirebaseAuthException catch (e) {
      Utils.showErrorMessage(context, e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
            
                // Logo
                Image.asset(
                  'assets/images/joola.png',
                  height: 100
                ),
            
                const SizedBox(height: 50),
            
                // Log in
                Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.grey.shade700,
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
                GestureDetector(
                  onTap: resetPassword,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.grey.shade600)
                        )
                      ]
                    )
                  ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey.shade700)
                        )
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400
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
                    SquareTile(imagePath: 'assets/images/google.png', height: 40),
                    SizedBox(width: 25),
                    SquareTile(imagePath: 'assets/images/apple.png', height: 40)
                  ]
                ),
            
                const SizedBox(height: 50),
            
                // Resgister
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey.shade700)
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
