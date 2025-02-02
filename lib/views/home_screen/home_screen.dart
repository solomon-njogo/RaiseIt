import 'package:flutter/material.dart';
import 'package:raiseit/components/bottom_navigation.dart';
import 'package:raiseit/views/campgain/campgain_screen.dart';
import 'package:raiseit/views/donations/my_donations_screen.dart';
import 'package:raiseit/views/home_screen/categories_card.dart';
import 'package:raiseit/views/home_screen/home_header.dart';
import 'package:raiseit/views/home_screen/trending_card.dart';
import 'package:raiseit/views/home_screen/urgent_card.dart';
import 'package:raiseit/views/profile_screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onTabChanged,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  children: [
                    const HomeHeader(),
                    SizedBox(height: screenHeight * 0.02),
                    _buildYourContributionsSection(screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    _buildCategoriesSection(screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    _buildUrgentSection(screenHeight, screenWidth),
                    SizedBox(height: screenHeight * 0.02),
                    _buildTrendingSection(screenHeight),
                  ],
                ),
              ),
            ),
            const CampgainScreen(),
            const MyDonationsScreen(),
            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          initialIndex: _selectedIndex,
          onTabChanged: _onTabChanged,
        ),
      ),
    );
  }

  Widget _buildUrgentSection(double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Urgent",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: screenHeight * 0.01),
        SizedBox(
          height: screenHeight * 0.35,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) => SizedBox(width: screenWidth * 0.02),
            itemBuilder: (context, index) {
              return const UrgentCard(
                imagePath: 'assets/images/3d-cartoon-character-b.png',
                title: "Medical Aid",
                progress: 0.5,
                currentAmount: 12000,
                totalAmount: 24000,
                category: "Medical",
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildYourContributionsSection(double screenWidth, double screenHeight) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: SizedBox(
        height: screenHeight * 0.18,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.009, vertical: screenHeight * 0.015),
                decoration: const BoxDecoration(
                  color: Color(0xFF002147),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance_wallet, color: Colors.white, size: 30),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Your Donation Pocket",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "\$ 240,200",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  // Handle click event here, e.g., navigate to another screen
                  print("Right side clicked");
                  // You can navigate to another screen like:
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => YourNextScreen()));
                },
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 38),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCategoriesSection(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: screenHeight * 0.01),
        SizedBox(
          height: screenHeight * 0.1,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (context, index) => SizedBox(width: screenHeight * 0.01),
            itemBuilder: (context, index) {
              return const CategoriesCard(
                imagePath: 'assets/images/3d-cartoon-character-b.png',
                title: "Medical",
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingSection(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Trending", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Spacer(),
            Text("More", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey, fontSize: 18)),
          ],
        ),
        SizedBox(height: screenHeight * 0.01),
        SizedBox(
          height: screenHeight * 0.35,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => SizedBox(width: screenHeight * 0.02),
            itemBuilder: (context, index) {
              return const TrendingCard(
                imagePath: 'assets/images/rendering-anime-doctors-work.png',
                title: "Helping Kenyan Medical Workers",
                progress: 0.5,
                currentAmount: 12000,
                totalAmount: 24000,
              );
            },
          ),
        ),
      ],
    );
  }
}
