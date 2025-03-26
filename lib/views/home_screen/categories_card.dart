import 'package:flutter/material.dart';
import 'package:raiseit/models/categories_model.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600 && screenWidth <= 900;
    final isDesktop = screenWidth > 900;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 32.0 : isTablet ? 24.0 : 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: TextStyle(
                fontSize: isDesktop ? 22 : isTablet ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: charityCategoryIcons.entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 12.0 : isTablet ? 10.0 : 8.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: isDesktop ? 90 : isTablet ? 75 : screenWidth * 0.15,
                        height: isDesktop ? 90 : isTablet ? 75 : screenHeight * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          entry.value,
                          size: isDesktop ? 42 : isTablet ? 36 : screenWidth * 0.08,
                          color: Colors.blue[900],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.key,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isDesktop ? 18 : isTablet ? 16 : screenWidth * 0.035,
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
      ),
    );
  }
}
