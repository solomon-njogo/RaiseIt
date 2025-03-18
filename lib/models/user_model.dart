class UserModel {
  final String name;
  final String email;

  UserModel({required this.name, required this.email});

  /// Convert Firestore data to a `UserModel`
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? 'Unknown User',
      email: data['email'] ?? 'No email provided',
    );
  }
}
