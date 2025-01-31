import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Divider between AppBar and content
          const Divider(
            height: 1,
            color: Colors.grey,
            thickness: 0.5,
          ),

          // Settings List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Dark Mode Option
                ListTile(
                  title: const Text("Dark Mode"),
                  trailing: Switch(
                    value: false, // Static value, logic not implemented
                    onChanged: (value) {},
                  ),
                ),

                // Notifications Toggle
                ListTile(
                  title: const Text("Enable Notifications"),
                  trailing: Switch(
                    value: true, // Static value, logic not implemented
                    onChanged: (value) {},
                  ),
                ),

                // Language Selection
                ListTile(
                  title: const Text("Change Language"),
                  subtitle: const Text("English"), // Static value, logic not implemented
                  onTap: () {
                    // No action here, logic not implemented
                  },
                ),

                // Edit Profile
                ListTile(
                  title: const Text("Edit Profile"),
                  onTap: () {
                    // No action here, logic not implemented
                  },
                  trailing: const Icon(Icons.edit_outlined),
                ),

                // About Section
                ListTile(
                  title: const Text("About"),
                  onTap: () {
                    // No action here, logic not implemented
                  },
                  trailing: const Icon(Icons.info_outline),
                ),

                // Support Section
                ListTile(
                  title: const Text("Support"),
                  onTap: () {
                    // No action here, logic not implemented
                  },
                  trailing: const Icon(Icons.help_outline),
                ),

                // Reset Settings to Default
                ListTile(
                  title: const Text("Reset Settings"),
                  onTap: () {
                    // No action here, logic not implemented
                  },
                  trailing: const Icon(Icons.restore),
                ),

                // App Version
                ListTile(
                  title: const Text("App Version"),
                  subtitle: const Text("1.0.0"),
                  trailing: const Icon(Icons.info),
                ),

                // Logout Button
                ListTile(
                  title: const Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // No action here, logic not implemented
                  },
                  trailing: const Icon(
                      Icons.exit_to_app,
                      color: Colors.redAccent
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
