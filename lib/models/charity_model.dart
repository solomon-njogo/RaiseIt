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
      startDate: _parseDateTime(data['startDate']),
      // ✅ Use helper function
      endDate: _parseDateTime(data['endDate']),
      // ✅ Use helper function
      imageUrl: data['imageUrl'] ?? '',
      updates: List<String>.from(data['updates'] ?? []),
      status: data['status'] ?? 'Normal',
    );
  }

// ✅ Helper function to handle DateTime conversion
  static DateTime _parseDateTime(dynamic value) {
    if (value is Timestamp) {
      return value.toDate(); // If it's a Firestore Timestamp, convert it
    } else if (value is String) {
      return DateTime.tryParse(value) ??
          DateTime.now(); // If it's a string, parse it
    } else {
      return DateTime.now(); // Default to now if invalid
    }
  }
}
