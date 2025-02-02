import 'package:flutter/material.dart';

class CampgainsHeader extends StatelessWidget {
  const CampgainsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
      child: Row(
        children: [
          Expanded( // Use Expanded to take available space
            child: TextField(
              textAlign: TextAlign.left, // Align text to the left
              decoration: InputDecoration(
                hintText: 'Campaigns', // Placeholder text
                filled: true, // Fill the background
                fillColor: Colors.grey[300], // Set background color to grey
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0), // More rounded corners
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0), // More rounded corners
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0), // More rounded corners
                  borderSide: const BorderSide(color: Colors.blue), // Change color when focused
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // Padding inside the TextField
                suffixIcon: IconButton(
                  onPressed: () {
                    // Add search functionality here
                  },
                  icon: const Icon(Icons.search, size: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}