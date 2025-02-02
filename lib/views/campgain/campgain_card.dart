import 'package:flutter/material.dart';

class CampgainCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final double progress;
  final double currentAmount;
  final double totalAmount;
  final int daysLeft;
  final VoidCallback onTap; // Function to handle click event

  const CampgainCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.progress,
    required this.currentAmount,
    required this.totalAmount,
    required this.daysLeft,
    required this.onTap, // Required callback function
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap, // Make the entire card clickable
      borderRadius: BorderRadius.circular(12.0),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0), // Adds space between cards
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  imagePath,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0), // Space between image and text column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    // Location
                    Text(
                      location,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    // Progress Bar
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        // Amount Raised
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            '\$${currentAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Days Left
                        Text(
                          '$daysLeft days left',
                          style: TextStyle(
                            color: daysLeft <= 5 ? Colors.red : Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
