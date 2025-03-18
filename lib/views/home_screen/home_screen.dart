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
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 900;
            bool isTablet = constraints.maxWidth > 600 && constraints.maxWidth <= 900;

            return PageView(
              controller: _pageController,
              onPageChanged: _onTabChanged,
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 32.0 : isTablet ? 24.0 : 16.0,
                    vertical: isDesktop ? 24.0 : 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeHeader(),
                      SizedBox(height: screenHeight * 0.02),
                      _buildYourContributionsSection(screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildCategoriesSection(isDesktop),
                      SizedBox(height: screenHeight * 0.02),
                      _buildUrgentSection(),
                      SizedBox(height: screenHeight * 0.02),
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
      child: Padding(
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
                    const Icon(Icons.account_balance_wallet, color: Colors.white, size: 30),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your Donation Pocket",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\$ 240,200",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.06,
                          ),
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

  Widget _buildCategoriesSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        isDesktop
            ? GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemCount: 10,
          itemBuilder: (_, index) => const CategoriesCard(
            imagePath: 'assets/images/3d-cartoon-character-b.png',
            title: "Medical",
          ),
        )
            : SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) => const CategoriesCard(
              imagePath: 'assets/images/3d-cartoon-character-b.png',
              title: "Medical",
            ),
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
          height: MediaQuery.of(context).size.height * 0.4,
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
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) => const TrendingCard(
              imagePath: 'assets/images/rendering-anime-doctors-work.png',
              title: "Helping Kenyan Medical Workers",
              progress: 0.5,
              currentAmount: 12000,
              totalAmount: 24000,
            ),
          ),
        ),
      ],
    );
  }
}
