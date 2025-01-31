import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date and time
import 'package:flutter/services.dart'; // For clipboard functionality

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  // Dummy transaction details
  final double donatedAmount = 100.50; // Example amount
  final String organization = 'Save the Earth Foundation'; // Example organization
  final String transactionId = 'TXN123456789'; // Example transaction ID
  final DateTime transactionDate = DateTime.now(); // Current date and time

  // Function to copy the transaction ID to clipboard
  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: transactionId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation'),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove app bar shadow
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {}, // Implement share feature on button press
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add padding to sides
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Centering everything horizontally
              children: [
                // Correctly displaying an image
                Image.asset('assets/images/3d-hand-using-online-banking-app-smartphone.png'),

                const SizedBox(height: 5),

                // Donation details
                Text(
                  '\$${donatedAmount.toStringAsFixed(2)}', // Added dollar sign in front of amount
                  style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold), // Increased font size
                  textAlign: TextAlign.center, // Center the text
                ),
                const SizedBox(height: 10,),
                Text(
                  'Donation Successful', // Format amount to 2 decimal places
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center, // Center the text
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the row contents
                  children: [
                    Text(
                      'to ',
                      style: const TextStyle(fontSize: 18), // Slightly bold organization name
                    ),
                    Text(
                      organization,
                      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.green), // Slightly bold organization name
                    ),
                  ],
                ),
                Text(
                  'Transaction Date: ${DateFormat.yMMMd().format(transactionDate)} · ${DateFormat.jm().format(transactionDate)}', // Added interpunct between date and time
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center, // Center the text
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the row contents
                  children: [
                    Text(
                      'ID: $transactionId',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.grey), // Changed to grey
                      onPressed: _copyToClipboard, // Copy the transaction ID to clipboard
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // View Details Button (underlined)
                TextButton(
                  onPressed: () {
                    // Navigate to view details screen or show more information
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("View more details..."),
                        backgroundColor: Colors.blue,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal, // Normal weight for the text
                      color: Colors.blue,
                      decoration: TextDecoration.underline, // Underlined text
                    ),
                  ),
                ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Example action on donation
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Go back to donation page"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          'Donate again',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Space between buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Example action on donation
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Thank you for your donation"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          'Done',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
