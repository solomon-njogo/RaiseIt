import 'package:flutter/material.dart';

// Define a Map of categories and their corresponding icons
final Map<String, IconData> charityCategoryIcons = {
  "Nonprofit": Icons.business,
  "Community": Icons.people,
  "Emergency": Icons.warning,
  "Medical": Icons.local_hospital,
  "Memorial": Icons.emoji_events,
  "Environment": Icons.eco,
  "Animal": Icons.pets,
  "Faith": Icons.church,
  "Volunteer": Icons.volunteer_activism,
  "Family": Icons.family_restroom,
  "Wishes": Icons.card_giftcard,
};

// Create a list of category names from the map keys
final List<String> charityCategories = charityCategoryIcons.keys.toList();
