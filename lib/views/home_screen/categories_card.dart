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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.25, // Adjusts for different screen sizes
      constraints: BoxConstraints(
        maxWidth: 180, // Limits max width for large screens
        minWidth: 100, // Ensures it doesn't get too small
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.015,
            horizontal: screenWidth * 0.02,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: screenWidth * 0.15,
                  height: screenHeight * 0.08,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: screenHeight * 0.008),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.035,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // Prevents overflow
              ),
            ],
          ),
        ),
      ),
    );
  }
}
