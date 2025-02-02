import 'package:flutter/material.dart';
import 'package:raiseit/views/settings_screens/settings_screen.dart';
import '../../components/bottom_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions dynamically
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none, // Ensures items can overflow
        children: [
          /// **🔹 Background Layer (Full-Screen Blurred Image)**
          Container(
            height: screenHeight * 0.35, // Covers 35% of screen height
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/3d-cartoon-character-b.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.4), // Dark overlay
            ),
          ),

          /// **🔹 Top Navigation Buttons**
          Positioned(
            top: screenHeight * 0.02,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    // Settings or more options functionality
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsScreen()),
                    );
                  },
                  icon: const Icon(Icons.more_horiz_outlined, size: 28, color: Colors.white),
                ),
              ],
            ),
          ),

          /// **🔹 Foreground Layer (Profile Details)**
          Positioned(
            top: screenHeight * 0.18, // Adjust to make space for the overlapping avatar
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: screenWidth,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.03,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 60), // Space for the avatar overlap

                  /// **🔹 User Name**
                  const Text(
                    "John Doe",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  /// **🔹 User Email**
                  const Text(
                    "johndoe@example.com",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// **🔹 Action Buttons (Message, Follow & Share)**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// **Private Message Button**
                      ElevatedButton(
                        onPressed: () {
                          // Private Message functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          shape: const CircleBorder(),
                          minimumSize: Size(screenWidth * 0.18, screenWidth * 0.18), // Ensures a circle
                          elevation: 3,
                        ),
                        child: const Icon(Icons.message_outlined, size: 28, color: Colors.blue),
                      ),

                      const Spacer(), // Space between buttons

                      /// **Follow Button**
                      ElevatedButton(
                        onPressed: () {
                          // Follow functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.15,
                            vertical: screenHeight * 0.015,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Text(
                          "Follow",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Spacer(), // Space between buttons

                      /// **Share Profile Button**
                      ElevatedButton(
                        onPressed: () {
                          // Share Profile functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          shape: const CircleBorder(),
                          minimumSize: Size(screenWidth * 0.18, screenWidth * 0.18), // Ensures a circle
                          elevation: 3,
                        ),
                        child: const Icon(Icons.share_outlined, size: 28, color: Colors.blue),
                      ),
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),


                  /// ** Info section (Followers, Donations & Organisations)**
                  Row(
                    children: [
                      /// **Followers Column**
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "870",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Vertical Divider
                      Container(
                        height: 40, // Adjust the height of the divider
                        width: 1, // Width of the line
                        color: Colors.grey, // Color of the divider
                      ),

                      /// **Donations Column**
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "500",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Donations",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Vertical Divider
                      Container(
                        height: 40, // Adjust the height of the divider
                        width: 1, // Width of the line
                        color: Colors.grey, // Color of the divider
                      ),

                      /// **Organisations Column**
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "28",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Organisations",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  ///** Organisations display section
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                              "Organisations",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Spacer(),

                          TextButton(
                              onPressed: () {},
                              child: Text("View all",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                          )
                        ],
                      ),

                      /// Organisation card placeholder
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Start the items from the left
                          children: List.generate(10, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adds space between the items
                              child: InkWell(
                                onTap: () {
                                  // Show notification as a SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("You clicked on Organisation ${index + 1}"),
                                      duration: const Duration(seconds: 1), // Duration for the SnackBar
                                      backgroundColor: Colors.blue, // Custom background color
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: screenWidth * 0.15, // Adjust size dynamically
                                      backgroundImage: const AssetImage('assets/images/3d-cartoon-character-b.png'),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Organisation ${index + 1}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          /// **🔹 Overlapping Profile Image**
          Positioned(
            top: screenHeight * 0.075, // Adjusted for better overlap
            left: screenWidth * 0.5 - (screenWidth * 0.2), // Center it
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: screenWidth * 0.2, // Adjust size dynamically
                backgroundImage: const AssetImage('assets/images/3d-cartoon-character-b.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
