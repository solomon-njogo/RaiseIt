import 'package:flutter/material.dart';
import 'package:raiseit/views/campgain/campgain_card.dart';
import 'package:raiseit/views/campgain/campgains_categories.dart';
import 'package:raiseit/views/campgain/campgains_header.dart';

class CampgainScreen extends StatefulWidget {
  const CampgainScreen({super.key});

  @override
  _CampgainScreenState createState() => _CampgainScreenState();
}

class _CampgainScreenState extends State<CampgainScreen> {
  int _selectedIndex = 2;

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sample data for campgains
    final List<Map<String, dynamic>> campgains = [
      {
        'imagePath': 'assets/images/3d-cartoon-character-b.png',
        'title': 'Medical Aid',
        'location': 'City A',
        'progress': 0.5, // Ensure this is a double
        'currentAmount': 12000.0, // Ensure this is a double
        'totalAmount': 24000.0, // Ensure this is a double
        'daysLeft': 10,
      },
      {
        'imagePath': 'assets/images/3d-cartoon-character-b.png',
        'title': 'Education Fund',
        'location': 'City B',
        'progress': 0.7, // Ensure this is a double
        'currentAmount': 17000.0, // Ensure this is a double
        'totalAmount': 24000.0, // Ensure this is a double
        'daysLeft': 5,
      },
      {
        'imagePath': 'assets/images/3d-cartoon-character-b.png',
        'title': 'Education Fund',
        'location': 'City B',
        'progress': 0.7, // Ensure this is a double
        'currentAmount': 17000.0, // Ensure this is a double
        'totalAmount': 24000.0, // Ensure this is a double
        'daysLeft': 5,
      },
      {
        'imagePath': 'assets/images/3d-cartoon-character-b.png',
        'title': 'Education Fund',
        'location': 'City B',
        'progress': 0.7, // Ensure this is a double
        'currentAmount': 17000.0, // Ensure this is a double
        'totalAmount': 24000.0, // Ensure this is a double
        'daysLeft': 5,
      }
    ];

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16.0), // Add padding here
          child: Column(
            children: [
              const CampgainsHeader(),
              const SizedBox(height: 10),
              const CampgainsCategories(),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: campgains.length,
                  itemBuilder: (context, index) {
                    final campgain = campgains[index];
                    return CampgainCard(
                      imagePath: campgain['imagePath'],
                      title: campgain['title'],
                      location: campgain['location'],
                      progress: campgain['progress'].toDouble(), // Ensure this is a double
                      currentAmount: campgain['currentAmount'].toDouble(), // Ensure this is a double
                      totalAmount: campgain['totalAmount'].toDouble(), // Ensure this is a double
                      daysLeft: campgain['daysLeft'],
                      onTap: () { print("campgain card tapped"); },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}