import 'package:flutter/material.dart';
import 'package:raiseit/views/auth_screens/signup_screen.dart';
import 'package:raiseit/views/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false; // Controls password visibility
  final TextEditingController _emailController = TextEditingController(); // Controller for email
  final TextEditingController _passwordController = TextEditingController(); // Controller for password

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "RAISE IT",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              const Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Email Field
              TextField(
                controller: _emailController, // Assign controller
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // Password Field with Toggle
              TextField(
                controller: _passwordController, // Assign controller
                obscureText: !_isPasswordVisible, // Toggle visibility
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible; // Toggle state
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Forgot Password Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Implement forgot password functionality
                  },
                  child: const Text("Forgot Password?"),
                ),
              ),

              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // Get email and password from controllers
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();

                    // Validate input
                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all fields."),
                        ),
                      );
                      return;
                    }

                    try {
                      // Sign in with Firebase
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      // Navigate to home screen after successful login
                      // Replace `HomeScreen()` with your actual home screen widget
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    } on FirebaseAuthException catch (e) {
                      // Handle errors
                      String errorMessage = "Login failed. Please try again.";
                      if (e.code == 'user-not-found') {
                        errorMessage = "No user found for this email.";
                      } else if (e.code == 'wrong-password') {
                        errorMessage = "Wrong password provided.";
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Don't have an account? Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign-up screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}