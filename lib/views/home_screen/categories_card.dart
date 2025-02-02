import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const CategoriesCard({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.01, // Adjust vertical padding dynamically
          horizontal: screenWidth * 0.03, // Adjust horizontal padding dynamically
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: screenWidth * 0.12, // Adjust width based on screen size
                height: screenHeight * 0.04, // Adjust height based on screen size
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: screenHeight * 0.002), // Adjust space dynamically
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04, // Adjust font size based on screen width
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
