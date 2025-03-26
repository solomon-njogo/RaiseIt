import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raiseit/models/charity_model.dart';

class HomeViewModel extends ChangeNotifier {
  int selectedIndex = 0;
  String selectedFilter = 'All';
  bool isAscending = true;

  final PageController pageController = PageController();

  void changeTab(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void updateFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  void toggleSortOrder() {
    isAscending = !isAscending;
    notifyListeners();
  }

  Stream<List<Charity>> fetchFilteredCharities() {
    Query query = FirebaseFirestore.instance.collection('charities');

    if (selectedFilter == "Trending") {
      query = query.where('status', isEqualTo: 'Trending');
    } else if (selectedFilter == "Urgency") {
      query = query.where('status', isEqualTo: 'Urgent');
    } else if (selectedFilter == "Target Amount") {
      query = query.orderBy('targetAmount', descending: !isAscending);
    } else if (selectedFilter == "Amount Raised") {
      query = query.orderBy('raisedAmount', descending: !isAscending);
    }

    return query.snapshots().map((snapshot) {
      print("Fetched ${snapshot.docs.length} charities from Firestore.");
      return snapshot.docs.map((doc) => Charity.fromFirestore(doc)).toList();
    });
  }


}
