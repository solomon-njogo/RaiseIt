import 'package:flutter/material.dart';
import 'package:raiseit/views/payment_screen.dart';
import '../components/bottom_navigation.dart';

class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  _MyDonationsScreenState createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen> {
  int _selectedIndex = 3;

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentScreen()),
            );
          }, child: Text(
          "My donations screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        ),
      ),
    );
  }
}
