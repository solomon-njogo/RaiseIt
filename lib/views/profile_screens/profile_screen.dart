import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raiseit/viewmodels/profile_viewmodel.dart';
import 'package:raiseit/views/add_charity/add_charity_screen.dart';
import 'package:raiseit/views/profile_screens/development_screen.dart';
import 'package:raiseit/views/settings_screens/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String profilePicturePath = 'assets/images/3d-cartoon-character-b.png';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      var profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
      profileViewModel.fetchUserData();
      profileViewModel.listenForUserUpdates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ProfileViewModel>(
        builder: (context, profileViewModel, child) {
          final user = profileViewModel.user;

          return Scaffold(
            backgroundColor: Colors.transparent, // ✅ Transparent background
            appBar: AppBar(
              title: const Text("Profile"),
              backgroundColor: Colors.transparent, // ✅ Transparent AppBar
              elevation: 0, // ✅ Remove AppBar shadow
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black), // ✅ Back Button
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  ),
                  icon: const Icon(Icons.settings, size: 28, color: Colors.black87),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    /// **🔹 Profile Image & Name**
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(profilePicturePath),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            user?.name ?? "Unknown User",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                          ),
                          Text(user?.email ?? "No email provided", style: const TextStyle(fontSize: 16, color: Colors.grey)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(thickness: 1.5),

                    /// **🔹 Profile Options (Scrollable List)**
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
                      children: [
                        _buildProfileOption(Icons.security, "Security & Privacy", () {}),
                        _buildProfileOption(Icons.code, "Development", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DevelopmentScreen()),
                          );
                        }),
                        _buildProfileOption(Icons.favorite, "Create New Charity", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddCharityScreen()),
                          );
                        }),
                        _buildProfileOption(Icons.notifications, "Notifications", () {}),
                        _buildProfileOption(Icons.support_agent, "Help & Support", () {}),
                        _buildProfileOption(Icons.info_outline, "About", () {
                          _showAboutDialog(context);
                        }),
                        _buildProfileOption(Icons.exit_to_app, "Log Out", () {
                          _logoutUser();
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return Card(
      color: Colors.blue[50],
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[900]),
        title: Text(title, style: TextStyle(fontSize: 18, color: Colors.blue[900])),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: "RaiseIt",
      applicationVersion: "1.0.0",
      applicationLegalese: "© 2025 RaiseIt Inc.",
    );
  }

  void _logoutUser() {
    print("User logged out");
  }
}
