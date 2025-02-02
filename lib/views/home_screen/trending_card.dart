import 'package:flutter/material.dart';
import 'package:raiseit/views/charities/charity_details_screen.dart'; // Import the CharityDetailsScreen

class TrendingCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double progress;
  final int currentAmount;
  final int totalAmount;

  const TrendingCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.progress,
    required this.currentAmount,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: GestureDetector(
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
                category: 'Trending', // Add category or use your own logic
                description: 'More details about this trending charity.',
              ),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(16),
          child: Column(
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
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.white, size: 30),
                      onPressed: () => print("Added to favorites"),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: progress,
                  color: Colors.blue,
                  backgroundColor: Colors.grey[300],
                  minHeight: 8,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text("\$$currentAmount", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue)),
                  const Text(" of ", style: TextStyle(fontSize: 15, color: Colors.grey)),
                  Text("\$$totalAmount", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const Text(" funded", style: TextStyle(fontSize: 15, color: Colors.grey)),
                  const Spacer(),
                  Text("${(progress * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
