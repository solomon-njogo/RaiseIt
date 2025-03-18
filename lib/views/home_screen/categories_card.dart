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
      width: screenWidth * 0.35, // Increased width
      constraints: const BoxConstraints(
        maxWidth: 220, // Increased max width for larger screens
        minWidth: 120, // Increased min width for smaller screens
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.04,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: screenWidth * 0.25, // Increased image width
                  height: screenHeight * 0.12, // Increased image height
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: screenHeight * 0.012),
              SizedBox(
                height: 50, // Increased height for better readability
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04, // Slightly larger font size
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // Prevents overflow
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
