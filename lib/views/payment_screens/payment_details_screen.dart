import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:raiseit/views/donations/my_donations_screen.dart';

class PaymentDetailsScreen extends StatefulWidget {
  final double donatedAmount; // Actual donated amount
  final String organization; // Real charity name
  final String transactionId;
  final DateTime transactionDate;

  const PaymentDetailsScreen({
    super.key,
    required this.donatedAmount,
    required this.organization,
    required this.transactionId,
    required this.transactionDate,
  });

  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  // Function to copy the transaction ID to clipboard
  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.transactionId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Transaction ID copied to clipboard")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation'),
        backgroundColor: Colors.blue[900], // Set to blue[900]
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image
                Image.asset('assets/images/3d-hand-using-online-banking-app-smartphone.png'),

                const SizedBox(height: 5),

                // Donation Amount
                Text(
                  '\KSH ${widget.donatedAmount.toStringAsFixed(2)}', // Use actual donated amount
                  style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // Success Message
                const Text(
                  'Donation Successful',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('to ', style: TextStyle(fontSize: 18)),
                    Text(
                      widget.organization, // Use actual charity name
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.blue[900]),
                    ),
                  ],
                ),

                Text(
                  'Transaction Date: ${DateFormat.yMMMd().format(widget.transactionDate)} · ${DateFormat.jm().format(widget.transactionDate)}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ID: ${widget.transactionId}', style: const TextStyle(fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.grey),
                      onPressed: _copyToClipboard,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // View Details Button (Underlined)
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("View more details..."),
                        backgroundColor: Colors.blue,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Go back to donation screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          'Donate again',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Thank you for your donation"),
                              backgroundColor: Colors.blue,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // Wait until the SnackBar disappears, then navigate
                          ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Ensure no overlap
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const MyDonationsScreen()),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Done',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
