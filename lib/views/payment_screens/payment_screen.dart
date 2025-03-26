import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raiseit/views/payment_screens/payment_details_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String charityId;

  const PaymentScreen({super.key, required this.charityId});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  String selectedCurrency = 'KSH';
  final List<String> currencies = ['KSH', 'USD', 'EUR', 'GBP', 'NGN'];

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() => setState(() {}));
  }

  String _getBadge(double amount) {
    if (amount >= 100000) return "🏆 Legendary Donor";
    if (amount >= 50000) return "❤️ Life Saver";
    if (amount >= 20000) return "💎 Platinum Donor";
    if (amount >= 10000) return "🌟 Hero Donor";
    if (amount >= 5000) return "🔥 Champion";
    if (amount >= 1000) return "💖 Kind Soul";
    if (amount >= 500) return "🌱 Generous Giver";
    return "🤝 Supporter";
  }

  void _showCurrencyDialog() {
    showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Currency'),
          content: DropdownButton<String>(
            value: selectedCurrency,
            onChanged: (newCurrency) {
              if (newCurrency != null) {
                setState(() => selectedCurrency = newCurrency);
              }
              Navigator.pop(context);
            },
            items: currencies.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
          ),
        );
      },
    );
  }

  Future<void> _processDonation() async {
    double? donationAmount = double.tryParse(_amountController.text);
    if (donationAmount == null || donationAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter a valid donation amount")));
      return;
    }

    DocumentReference charityRef = FirebaseFirestore.instance.collection('charities').doc(widget.charityId);
    try {
      DocumentSnapshot charitySnapshot = await charityRef.get();
      if (!charitySnapshot.exists) throw Exception("Charity does not exist!");

      String charityName = charitySnapshot.get('name');
      double newRaisedAmount = (charitySnapshot.get('raisedAmount') ?? 0).toDouble() + donationAmount;
      String donorBadge = _getBadge(donationAmount);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(charityRef, {'raisedAmount': newRaisedAmount});
        transaction.set(FirebaseFirestore.instance.collection('donations').doc(), {
          'charityId': widget.charityId,
          'charityName': charityName,
          'amount': donationAmount,
          'currency': selectedCurrency,
          'date': Timestamp.now(),
          'badge': donorBadge,
        });
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentDetailsScreen(
            donatedAmount: donationAmount,
            organization: charityName,
            transactionId: 'TXN${DateTime.now().millisecondsSinceEpoch}',
            transactionDate: DateTime.now(),
            donorBadge: donorBadge,
          ),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to process donation: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.currency_exchange), onPressed: _showCurrencyDialog),
        ],
      ),
      body: Center(
        child: Container(
          width: isWideScreen ? 500 : screenWidth * 0.9,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  prefixText: "$selectedCurrency ",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _processDonation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Donate $selectedCurrency ${_amountController.text}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}