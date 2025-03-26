import 'package:flutter/material.dart';
import 'dart:math';

class CampgainScreen extends StatelessWidget {
  final List<String> activities = List.generate(
    100,
        (index) => _generateRandomActivity(),
  );

  static String _generateRandomActivity() {
    final random = Random();
    final actions = [
      "donated \$${random.nextInt(500) + 10} to",
      "started a new campaign:",
      "reached a milestone of \$${random.nextInt(10000) + 1000} in",
      "shared a fundraiser:",
      "commented on",
      "matched a donation for",
      "volunteered for",
      "posted an update on",
    ];
    final campaigns = [
      "Education for All",
      "Clean Water Initiative",
      "Medical Aid Fund",
      "Food Relief Program",
      "Animal Welfare Support",
      "Emergency Disaster Relief",
      "Help for Homeless",
      "Support Local Businesses",
      "Scholarship Fund",
      "Climate Change Awareness",
    ];
    return "User ${random.nextInt(5000)} ${actions[random.nextInt(actions.length)]} ${campaigns[random.nextInt(campaigns.length)]}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Updates"),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[700],
                child: Icon(Icons.volunteer_activism, color: Colors.white),
              ),
              title: Text(
                activities[index],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: Text("Just now", style: TextStyle(color: Colors.grey[600])),
            ),
          );
        },
      ),
    );
  }
}
