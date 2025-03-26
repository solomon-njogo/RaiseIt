import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:raiseit/views/donations/my_donations_screen.dart';

class PaymentDetailsScreen extends StatefulWidget {
  final double donatedAmount;
  final String organization;
  final DateTime transactionDate;
  final String transactionId;

  const PaymentDetailsScreen({
    Key? key,
    required this.donatedAmount,
    required this.organization,
    required this.transactionDate,
    required this.transactionId,
    required String donorBadge,
  }) : super(key: key);

  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.transactionId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Transaction ID copied to clipboard"),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Payment Details'),
        backgroundColor: Colors.blue[900],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Image
                Image.asset('assets/images/3d-hand-using-online-banking-app-smartphone.png'),

                const SizedBox(height: 5),

                // Donation Amount
                Text(
                  'KSH ${widget.donatedAmount.toStringAsFixed(2)}',
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
                      widget.organization,
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.blue[900]),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // Transaction Details
                Text(
                  'Transaction Date: ${DateFormat.yMMMd().format(widget.transactionDate)} · ${DateFormat.jm().format(widget.transactionDate)}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 5),

                // Transaction ID with Copy Button
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

                const SizedBox(height: 20),

                // Buttons: Donate Again & Done
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
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
