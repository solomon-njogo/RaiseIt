import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:raiseit/views/home_screen/home_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Controllers for text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                "Create an account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Full Name Field
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  hintText: "Enter your full name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 20),

              // Email Field
              TextField(
                controller: _emailController,
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
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
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
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Confirm Password Field with Toggle
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Re-enter your password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // Get input values
                    String fullName = _fullNameController.text.trim();
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    String confirmPassword = _confirmPasswordController.text.trim();

                    // Validate input
                    if (fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all fields."),
                        ),
                      );
                      return;
                    }

                    // Check if passwords match
                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Passwords do not match."),
                        ),
                      );
                      return;
                    }

                    try {
                      // Create user with Firebase
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      // Navigate to home screen after successful sign-up
                      // Replace `HomeScreen()` with your actual home screen widget
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    } on FirebaseAuthException catch (e) {
                      // Handle errors
                      String errorMessage = "Sign-up failed. Please try again.";
                      if (e.code == 'weak-password') {
                        errorMessage = "The password provided is too weak.";
                      } else if (e.code == 'email-already-in-use') {
                        errorMessage = "The account already exists for that email.";
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("An error occurred: $e"),
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
                    "Sign Up",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Already have an account? Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      // Navigate to login screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text("Login"),
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