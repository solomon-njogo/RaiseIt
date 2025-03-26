import 'package:flutter/material.dart';
import 'package:raiseit/models/categories_model.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Allows scrolling horizontally
      child: Column(
        children: [
          Text(
            "Categories",
            style: TextStyle(
              fontSize: 18, // Adjust size as needed
              fontWeight: FontWeight.bold, // Make it bold
              color: Colors.black, // Black color
            ),
            textAlign: TextAlign.start, // Align text to the start (left)
          ),
          Row(
            children: charityCategoryIcons.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.15, // Adjust width dynamically
                      height: screenHeight * 0.08, // Adjust height dynamically
                      decoration: BoxDecoration(
                        color: Colors.blue[100], // Background color
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        entry.value, // Get the icon from the map
                        size: screenWidth * 0.08, // Adjust icon size
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      entry.key, // Category name
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035, // Adjust font size
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
