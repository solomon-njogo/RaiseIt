import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:raiseit/models/charity_model.dart';
import 'package:raiseit/views/auth_screens/login_screen.dart';
import 'package:raiseit/views/home_screen/home_screen.dart';
import 'package:raiseit/views/profile_screens/profile_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key, });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Check if user is logged in
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;

          if (user == null) {
            return const LoginScreen(); // Go to Login Page if not logged in
          } else {
            return HomeScreen(); // Go to Home Page if logged in
          }
        }

        // Show loading screen while checking auth state
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
