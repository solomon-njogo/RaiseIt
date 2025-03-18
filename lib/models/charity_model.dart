import 'package:cloud_firestore/cloud_firestore.dart';

class Charity {
  final String id;
  final String name;
  final String description;
  final String category;
  final String location;
  final double targetAmount;
  final double raisedAmount;
  final DateTime startDate;
  final DateTime endDate;
  final String imageUrl;
  final List<String> updates;
  final String status;
  // final String blockchainAddress; // Unique blockchain address for the charity
  // final List<Transaction> transactions; // List of blockchain transactions

  Charity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.location,
    required this.targetAmount,
    required this.raisedAmount,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
    required this.updates,
    required this.status,
    //required this.blockchainAddress,
    //required this.transactions,
  });


  // Factory method to create a Charity object from Firestore
  factory Charity.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Charity(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      location: data['location'] ?? '',
      targetAmount: (data['targetAmount'] ?? 0).toDouble(),
      raisedAmount: (data['raisedAmount'] ?? 0).toDouble(),
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      imageUrl: data['imageUrl'] ?? '',
      updates: List<String>.from(data['updates'] ?? []),
      status: data['status'] ?? 'Normal', // ✅ Default to Normal if missing
    );
  }
}
