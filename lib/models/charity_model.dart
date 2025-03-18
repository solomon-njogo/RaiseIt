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
    //required this.blockchainAddress,
    //required this.transactions,
  });
}
