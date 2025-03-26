import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  _MyDonationsScreenState createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Column(
        children: [
          _buildGradientAppBar(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Your Contributions",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('donations').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        var donations = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

                        if (donations.isEmpty) {
                          return const Center(
                            child: Text("No donations made yet.", style: TextStyle(fontSize: 18, color: Colors.grey)),
                          );
                        }

                        double totalDonations = donations.fold(0, (sum, item) => sum + (item["amount"] as num).toDouble());

                        return Column(
                          children: [
                            _buildSummaryCard(totalDonations),
                            const SizedBox(height: 15),
                            Expanded(
                              child: ListView.builder(
                                itemCount: donations.length,
                                itemBuilder: (context, index) {
                                  return _buildDonationCard(donations[index]);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.blue.shade600],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade300.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Center(
              child: Text(
                "My Donations",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(double totalDonations) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade500.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            "Total Donations",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            "KSH ${NumberFormat('#,##0').format(totalDonations)}",
            style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationCard(Map<String, dynamic> donation) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(12), // Rounded square corners
          ),
          child: Text(
            "KSH ${(donation['amount'] as num).toInt()}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        title: Text(
          donation["charityName"],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
        ),
        subtitle: Text(
          "${DateFormat('MMM d, yyyy').format((donation['date'] as Timestamp).toDate())}  •  ${donation['badge']}",
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.share, color: Colors.blue),
          onPressed: () => _shareDonation(donation["charityName"], (donation["amount"] as num).toDouble()),
        ),
      ),
    );
  }

  void _shareDonation(String title, double amount) {
    final message = "I just donated KSH ${NumberFormat('#,##0').format(amount)} to '$title'! 💖 Join me in making a difference! 🌍 #RaiseIt";
    Share.share(message);
  }
}
