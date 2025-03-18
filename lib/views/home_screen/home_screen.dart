import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raiseit/components/bottom_navigation.dart';
import 'package:raiseit/models/charity_model.dart';
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

  Stream<List<Charity>> _fetchCharitiesByStatus(String status) {
    return FirebaseFirestore.instance
        .collection('charities')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Charity.fromFirestore(doc)).toList());
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
          itemBuilder: (_, index) => const CategoriesCard(),
        )
            : const CategoriesCard(),
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
          child: StreamBuilder<List<Charity>>(
            stream: _fetchCharitiesByStatus("Urgent"),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No urgent campaigns found."));
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) {
                  Charity charity = snapshot.data![index];
                  return UrgentCard(
                    imagePath: charity.imageUrl,
                    title: charity.name,
                    progress: charity.raisedAmount / charity.targetAmount,
                    currentAmount: charity.raisedAmount.toInt(),  // ✅ Convert to int
                    totalAmount: charity.targetAmount.toInt(),    // ✅ Convert to int

                    category: charity.category,
                  );
                },
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
        const Text("Trending", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: StreamBuilder<List<Charity>>(
            stream: _fetchCharitiesByStatus("Trending"),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No trending campaigns found."));
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) {
                  Charity charity = snapshot.data![index];
                  return TrendingCard(
                    imagePath: charity.imageUrl,
                    title: charity.name,
                    progress: charity.raisedAmount / charity.targetAmount,
                    currentAmount: charity.raisedAmount.toInt(),  // ✅ Convert to int
                    totalAmount: charity.targetAmount.toInt(),    // ✅ Convert to int

                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
