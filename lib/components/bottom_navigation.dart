import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int> onTabChanged;

  const BottomNavigation({super.key, required this.initialIndex, required this.onTabChanged});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTabChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -10), // Lifts the navigation bar above the bottom edge
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0), // Adds margin to avoid touching sides
        decoration: BoxDecoration(
          color: Colors.white, // Set background color to white
          borderRadius: BorderRadius.circular(30), // Round all corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15, // Blur shadow for a smooth effect
              spreadRadius: 5, // Spread the shadow out
              offset: const Offset(0, 8), // Shadow direction
            ),
            BoxShadow(
              color: Colors.green.withOpacity(0.3), // Gradient-like effect with green
              blurRadius: 20,
              spreadRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30), // Ensure corners remain rounded
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            selectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.campaign),
                label: "Campaigns",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Donations",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
