import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:raiseit/models/user_model.dart';

class DatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// **Retrieve the logged-in user's ID**
  static String? get userId {
    final user = _auth.currentUser;
    return user?.uid;
  }

  /// **Fetch user data (Initial load)**
  static Future<UserModel?> getUser() async {
    final uid = userId;
    if (uid == null) {
      print("❌ No authenticated user found.");
      return null;
    }

    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }

    print("❌ User document does not exist for ID: $uid");
    return null;
  }

  /// **Real-time user updates from Firestore**
  static Stream<UserModel?> userStream() {
    final uid = userId;
    if (uid == null) {
      print("❌ No authenticated user for live updates.");
      return const Stream.empty();
    }

    return _db.collection('users').doc(uid).snapshots().map((doc) {
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
}
