import 'package:flutter/material.dart';
import 'package:raiseit/components/bottom_navigation.dart';
import 'package:raiseit/views/campgain/campgain_screen.dart';
import 'package:raiseit/views/charities/charity_details_screen.dart';
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
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 600;
            return PageView(
              controller: _pageController,
              onPageChanged: _onTabChanged,
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeHeader(),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      _buildYourContributionsSection(constraints.maxWidth),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      _buildCategoriesSection(),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      _buildUrgentSection(),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      _buildTrendingSection(),
                    ],
                  ),
                ),
                const CampgainScreen(),
                const MyDonationsScreen(),
                const ProfileScreen(),
              ],
            );
          },
        ),
        bottomNavigationBar: BottomNavigation(
          initialIndex: _selectedIndex,
          onTabChanged: _onTabChanged,
        ),
      ),
    );
  }

  Widget _buildYourContributionsSection(double screenWidth) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF002147),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet,
                        color: Colors.white, size: 30),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Your Donation Pocket",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\$ 240,200",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 24),
              onPressed: () {
                print("Right side clicked");
              },
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
        const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) {
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

  Widget _buildUrgentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Urgent", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CharityDetailsScreen(
                        title: "Medical Aid",
                        imagePath: 'assets/images/3d-cartoon-character-b.png',
                        progress: 0.5,
                        currentAmount: 12000,
                        totalAmount: 24000,
                        category: "Medical",
                        description: "Providing urgent medical aid to those in need.",
                      ),
                    ),
                  );
                },
                child: const UrgentCard(
                  imagePath: 'assets/images/3d-cartoon-character-b.png',
                  title: "Medical Aid",
                  progress: 0.5,
                  currentAmount: 12000,
                  totalAmount: 24000,
                  category: "Medical",
                ),
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
            const Text("Trending", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            GestureDetector(
              onTap: () {
                print("More clicked");
              },
              child: const Text("More", style: TextStyle(fontSize: 16, color: Colors.grey)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CharityDetailsScreen(
                        title: "Helping Kenyan Medical Workers",
                        imagePath: 'assets/images/rendering-anime-doctors-work.png',
                        progress: 0.5,
                        currentAmount: 12000,
                        totalAmount: 24000,
                        category: "Health",
                        description: "Supporting frontline medical workers in Kenya.",
                      ),
                    ),
                  );
                },
                child: const TrendingCard(
                  imagePath: 'assets/images/rendering-anime-doctors-work.png',
                  title: "Helping Kenyan Medical Workers",
                  progress: 0.5,
                  currentAmount: 12000,
                  totalAmount: 24000,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
