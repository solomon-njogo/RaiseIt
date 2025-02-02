import 'package:flutter/material.dart';
import 'package:raiseit/views/charities/charity_details_screen.dart'; // Import the CharityDetailsScreen

class UrgentCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double progress;
  final int currentAmount;
  final int totalAmount;
  final String category;

  const UrgentCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.progress,
    required this.currentAmount,
    required this.totalAmount,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to CharityDetailsScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharityDetailsScreen(
              title: title,
              imagePath: imagePath,
              progress: progress,
              currentAmount: currentAmount,
              totalAmount: totalAmount,
              category: category,
              description: 'More details about this urgent charity.',
            ),
          ),
        );
      },
      child: Card(
        shadowColor: Colors.grey,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.175,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2), // Semi-blurred effect
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: progress,
                  color: Colors.blue,
                  backgroundColor: Colors.grey[300],
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text("\$$currentAmount",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue)),
                  const Text(" of ", style: TextStyle(fontSize: 15, color: Colors.grey)),
                  Text("\$$totalAmount",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const Text(" funded", style: TextStyle(fontSize: 15, color: Colors.grey)),
                  const Spacer(),
                  Text("${(progress * 100).toInt()}%",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
