import 'package:flutter/material.dart';
import 'package:raiseit/views/campgain_screen.dart';
import 'package:raiseit/views/profile_screen.dart';
import '../components/bottom_navigation.dart';
import 'my_donations_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  // Callback function for tab changes
  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index); // Update PageView when a tab is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController, // Controller to manage the page
        onPageChanged: _onTabChanged,
        children: [
          // Home Screen Tab 
          Center(
            child: Text(
              "This is the Home Screen",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const MyDonationsScreen(),
          const CampgainScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        initialIndex: _selectedIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}
