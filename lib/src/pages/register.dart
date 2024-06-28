import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:joola/src/components/login_button.dart';
import 'package:joola/src/components/login_text.dart';
import 'package:joola/src/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
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
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
        );

        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        if (mounted) {
          Navigator.of(context).pop();
        }

        showErrorMessage('Passwords don\'t match');
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
      }
      
      showErrorMessage(e.code);
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
                  'Register here!',
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

                // Confirm password
                LoginText(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true
                ),
            
                const SizedBox(height: 25),
            
                // Sign up
                LoginButton(
                  onTap: signUp,
                  text: 'Sign Up'
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
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700])
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Log in now',
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
