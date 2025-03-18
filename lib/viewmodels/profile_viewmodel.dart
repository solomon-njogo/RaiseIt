import 'package:flutter/material.dart';
import 'package:raiseit/models/user_model.dart';
import 'package:raiseit/services/database_service.dart';

class ProfileViewModel extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  /// Fetch user data **on screen load**
  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();
    _user = await DatabaseService.getUser();
    _isLoading = false;
    notifyListeners();
  }

  /// **Listen for real-time updates**
  void listenForUserUpdates() {
    DatabaseService.userStream().listen((updatedUser) {
      _user = updatedUser;
      notifyListeners();
    });
  }
}
