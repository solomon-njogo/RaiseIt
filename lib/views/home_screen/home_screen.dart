import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raiseit/components/bottom_navigation.dart';
import 'package:raiseit/models/charity_model.dart';
import 'package:raiseit/viewmodels/home_viewmodel.dart';
import 'package:raiseit/views/campgain/campgain_screen.dart';
import 'package:raiseit/views/charities/charity_details_screen.dart';
import 'package:raiseit/views/donations/my_donations_screen.dart';
import 'package:raiseit/views/home_screen/categories_card.dart';
import 'package:raiseit/views/home_screen/home_header.dart';
import 'package:raiseit/views/profile_screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 900;
            bool isTablet = constraints.maxWidth > 600 && constraints.maxWidth <= 900;

            return PageView(
              controller: homeViewModel.pageController,
              onPageChanged: homeViewModel.changeTab,
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
                      SizedBox(height: mediaQuery.size.height * 0.02),
                      CategoriesCard(),
                      SizedBox(height: mediaQuery.size.height * 0.02),
                      _buildFilterAndCharities(context),
                    ],
                  ),
                ),
                CampgainScreen(),
                const MyDonationsScreen(),
                const ProfileScreen(),
              ],
            );
          },
        ),
        bottomNavigationBar: BottomNavigation(
          initialIndex: homeViewModel.selectedIndex,
          onTabChanged: homeViewModel.changeTab,
        ),
      ),
    );
  }

  Widget _buildFilterAndCharities(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("All Charities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.filter_list, size: 28),
              onPressed: () => _showFilterMenu(context),
            ),
          ],
        ),
        const SizedBox(height: 8),
        StreamBuilder<List<Charity>>(
          stream: homeViewModel.fetchFilteredCharities(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No charities found."));
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, index) {
                  Charity charity = snapshot.data![index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharityDetailsScreen(charity: charity),
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: charity.imageUrl.isNotEmpty
                                  ? Image.network(
                                charity.imageUrl,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                                  : Image.asset(
                                'assets/images/rendering-anime-doctors-work.png',
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              charity.name,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: charity.raisedAmount / charity.targetAmount,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _showFilterMenu(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Filter Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Column(
                children: ["All", "Trending", "Urgency", "Target Amount", "Amount Raised"]
                    .map((filter) => ListTile(
                  title: Text(filter),
                  trailing: homeViewModel.selectedFilter == filter
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    homeViewModel.updateFilter(filter);
                    Navigator.pop(context);
                  },
                ))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
