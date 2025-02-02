import 'package:flutter/material.dart';

class CampgainsCategories extends StatelessWidget {
  const CampgainsCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    // Sample data for categories
    final List<Map<String, dynamic>> categories = List.generate(10, (index) {
      return {
        'name': 'Category ${index + 1}',
        'count': index + 1, // Example count
      };
    });

    return Container(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02), // 2% of screen height
      height: screenSize.height * 0.1, // 10% of screen height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02), // 2% of screen width
            padding: EdgeInsets.all(screenSize.width * 0.01), // 4% of screen width
            decoration: BoxDecoration(
              color: Colors.grey[200], // Lightest shade of grey
              borderRadius: BorderRadius.circular(screenSize.width * 0.05), // 5% of screen width for rounded corners
            ),
            child: Row(
              children: [
                Text(
                  category['name'],
                  style: TextStyle(fontSize: screenSize.width * 0.04), // 4% of screen width for font size
                ),
                SizedBox(width: screenSize.width * 0.02), // 2% of screen width for spacing
                Container(
                  padding: EdgeInsets.all(screenSize.width * 0.02), // Adjusted padding for the circle
                  decoration: BoxDecoration(
                    color: Colors.white, // White background for the circle
                    shape: BoxShape.circle, // Make it a circle
                  ),
                  child: Center(
                    child: Text(
                      '${category['count']}',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.035, // 3.5% of screen width for font size
                        color: Colors.black, // Ensure text color is black for visibility
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}