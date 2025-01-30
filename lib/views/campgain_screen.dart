import 'package:flutter/material.dart';
import '../components/bottom_navigation.dart';

class CampgainScreen extends StatefulWidget {
  const CampgainScreen({super.key});

  @override
  _CampgainScreenState createState() => _CampgainScreenState();
}

class _CampgainScreenState extends State<CampgainScreen> {
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
        child: Text(
          "Campaigns screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
