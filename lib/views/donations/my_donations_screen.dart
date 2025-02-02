`import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  _MyDonationsScreenState createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen> {
  final List<Map<String, dynamic>> _donations = [
    {
      "title": "Education for All",
      "amount": 50.0,
      "date": "Jan 10, 2025",
      "badge": "📚 Knowledge Giver",
    },
    {
      "title": "Medical Aid for Kids",
      "amount": 75.0,
      "date": "Feb 5, 2025",
      "badge": "❤️ Life Saver",
    },
    {
      "title": "Clean Water Initiative",
      "amount": 100.0,
      "date": "Mar 20, 2025",
      "badge": "💧 Water Warrior",
    },
  ];

  void _shareDonation(String title, double amount) {
    final message =
        "I just donated \$$amount to '$title'! 💖 Join me in making a difference! 🌍 #RaiseIt";
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    double totalDonations =
    _donations.fold(0, (sum, item) => sum + item["amount"]);

    return Scaffold(
      body: Column(
        children: [
          _buildGradientAppBar(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCard(totalDonations),
                  const SizedBox(height: 20),
                  const Text(
                    "Your Contributions",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _donations.length,
                      itemBuilder: (context, index) {
                        final donation = _donations[index];
                        return _buildDonationCard(donation);
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const Center(
              child: Text(
                "My Donations",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade300.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Total Donations",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            "\$$totalDonations",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: totalDonations / 500, // Example: Goal of $500
            backgroundColor: Colors.white24,
            color: Colors.greenAccent,
          ),
          const SizedBox(height: 10),
          const Text(
            "You're making a huge impact! 🚀",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationCard(Map<String, dynamic> donation) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade800,
          child: Text(
            "\$${donation['amount'].toInt()}",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          donation["title"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${donation['date']}  •  ${donation['badge']}",
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.share, color: Colors.blue),
          onPressed: () => _shareDonation(donation["title"], donation["amount"]),
        ),
      ),
    );
  }
}