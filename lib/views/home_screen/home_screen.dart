import 'package:flutter/material.dart';
import 'package:raiseit/components/bottom_navigation.dart';
import 'package:raiseit/views/campgain_screen.dart';
import 'package:raiseit/views/home_screen/categories_card.dart';
import 'package:raiseit/views/home_screen/home_header.dart';
import 'package:raiseit/views/home_screen/trending_card.dart';
import 'package:raiseit/views/home_screen/urgent_card.dart';
import 'package:raiseit/views/my_donations_screen.dart';
import 'package:raiseit/views/profile_screen.dart';

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
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onTabChanged,
          children: [
            SingleChildScrollView( // Makes the page scrollable vertically
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const HomeHeader(),
                    const SizedBox(height: 20),
                    _buildYourContributionsSection(),
                    const SizedBox(height: 20),
                    _buildCategoriesSection(),
                    const SizedBox(height: 20),
                    _buildUrgentSection(),
                    const SizedBox(height: 20),
                    _buildTrendingSection(),
                  ],
                ),
              ),
            ),
            const MyDonationsScreen(),
            const CampgainScreen(),
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

  Widget _buildUrgentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Urgent",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return const UrgentCard(
                imagePath: 'assets/images/3d-cartoon-character-b.png',
                title: "Medical Aid",
                progress: 0.5,
                currentAmount: 12000,
                totalAmount: 24000,
                category: "Medical", // Example category
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildYourContributionsSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        height: 150, // Increased height to 150
        child: Row(
          children: [
            // Left Section - Dark Blue Background (Icon + Donation Details Side by Side)
            Expanded(
              flex: 2, // 2/3 of the width
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFF002147), // Dark Blue
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    ],
                  ),
                ),
              ),
            ),

            // Right Section - White Background (View Transactions takes 1/3 of the width)
            Expanded(
              flex: 1, // 1/3 of the width
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "View Transactions",
                        style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }





  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return const CategoriesCard(
                imagePath: 'assets/images/3d-cartoon-character-b.png',
                title: "Medical Aid",
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingSection() {
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
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
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
