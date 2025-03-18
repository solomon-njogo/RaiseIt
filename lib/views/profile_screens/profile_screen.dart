import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raiseit/viewmodels/profile_viewmodel.dart';
import 'package:raiseit/views/settings_screens/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String profilePicturePath = 'assets/images/3d-cartoon-character-b.png';

  final List<String> fakeOrganizations = [
    "Tech Innovators Ltd",
    "Future Builders Foundation",
    "Global AI Research",
    "Green Earth Initiative",
    "NextGen Coders Hub"
  ];

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          bool isWeb = screenWidth > 800;

          return Consumer<ProfileViewModel>(
            builder: (context, profileViewModel, child) {
              final user = profileViewModel.user;

              /// **🔹 Mobile Layout (With Overlapping Profile Picture)**
              if (!isWeb) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    /// **🔹 Background Image with Overlay**
                    Container(
                      height: screenHeight * 0.35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(profilePicturePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(color: Colors.black.withOpacity(0.5)),
                    ),

                    /// **🔹 Top Navigation (Back & Settings)**
                    Positioned(
                      top: screenHeight * 0.02,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SettingsScreen()),
                            ),
                            icon: const Icon(Icons.settings, size: 28, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    /// **🔹 Foreground (User Info)**
                    Positioned(
                      top: screenHeight * 0.22, // Push it down for the profile image overlap
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenHeight * 0.03),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 80), // Space for overlapping profile image
                              Text(user?.name ?? "Unknown User", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                              Text(user?.email ?? "No email provided", style: const TextStyle(fontSize: 18, color: Colors.grey)),
                              const Divider(thickness: 1.5),
                              const SizedBox(height: 10),

                              Column(
                                children: fakeOrganizations.map((org) {
                                  return Card(
                                    elevation: 3,
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    child: ListTile(
                                      leading: const Icon(Icons.business, color: Colors.blueGrey),
                                      title: Text(org, style: const TextStyle(fontSize: 18)),
                                      trailing: const Icon(Icons.chevron_right),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// **🔹 Overlapping Profile Picture**
                    Positioned(
                      top: screenHeight * 0.12, // Controls how much it overlaps
                      left: screenWidth * 0.5 - (screenWidth * 0.15),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: screenWidth * 0.15,
                          backgroundImage: AssetImage(profilePicturePath),
                        ),
                      ),
                    ),
                  ],
                );
              }

              /// **🔹 Web Layout (With Profile Image & Side Info)**
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Profile"),
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      ),
                      icon: const Icon(Icons.settings, size: 28),
                    ),
                  ],
                ),
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: screenHeight * 0.05),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// **🔹 Profile Card (With Overlapping Image)**
                        Column(
                          children: [
                            /// **🔹 Overlapping Profile Image**
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: screenWidth * 0.08,
                                backgroundImage: AssetImage(profilePicturePath),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(user?.name ?? "Unknown User", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text(user?.email ?? "No email provided", style: const TextStyle(fontSize: 16, color: Colors.grey)),
                          ],
                        ),

                        const SizedBox(width: 50),

                        /// **🔹 Organizations Section**
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Organizations", style: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Column(
                                  children: fakeOrganizations.map((org) {
                                    return Card(
                                      elevation: 3,
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      child: ListTile(
                                        leading: const Icon(Icons.business, color: Colors.blueGrey),
                                        title: Text(org, style: const TextStyle(fontSize: 18)),
                                        trailing: const Icon(Icons.chevron_right),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
