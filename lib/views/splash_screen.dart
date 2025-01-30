import 'package:flutter/material.dart';
import 'package:raiseit/views/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF43A047), // Darker Green
              Color(0xFF66BB6A), // Medium Green
              Color(0xFF81C784), // Lighter Green
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered Image
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/splash_screen.png',
                  width: 450,
                  height: 500,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
