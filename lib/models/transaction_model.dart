class Transaction {
  final String transactionId;
  final String donorId;
  final double amount;
  final DateTime date;
  final String status; // e.g., 'Pending', 'Confirmed', 'Failed'
  final String blockchainHash; // Unique hash of the blockchain transaction

  Transaction({
    required this.transactionId,
    required this.donorId,
    required this.amount,
    required this.date,
    required this.status,
    required this.blockchainHash,
  });
}
