import 'package:flutter/material.dart';
import 'package:raiseit/views/payment_screens/payment_screen.dart';

class CharityDetailsScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final double progress;
  final int currentAmount;
  final int totalAmount;
  final String category;
  final String description;

  const CharityDetailsScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.progress,
    required this.currentAmount,
    required this.totalAmount,
    required this.category,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            textAlign: TextAlign.center, // Centering the AppBar text
            style: const TextStyle(fontSize: 22),
          ),
          // Apply gradient to the AppBar background
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.withOpacity(0.5),
                  Colors.white,
                ],
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            // Scrollable Content Section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Charity Image
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Details Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title & Category
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                  softWrap: true,  // Allow text wrapping
                                  overflow: TextOverflow.visible, // Only overflow at the end
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  category,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis, // Only overflow at the end
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Progress Bar Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Progress",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "\$$currentAmount raised of \$$totalAmount",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[300],
                            color: Colors.green,
                          ),

                          // Description
                          Text(
                            description,
                            style: const TextStyle(fontSize: 16, height: 1.6),
                            softWrap: true,  // Ensure wrapping
                            overflow: TextOverflow.visible,  // Allow overflow if needed
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Donation Button placed at the bottom and fills full width
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,  // Makes the button fill the full width
                child: ElevatedButton(
                  onPressed: () {
                    // Handle donation logic here
                    // Navigate to the PaymentScreen when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaymentScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Donate Now",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
