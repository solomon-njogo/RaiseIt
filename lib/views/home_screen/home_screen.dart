import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raiseit/components/bottom_navigation.dart';
import 'package:raiseit/models/charity_model.dart';
import 'package:raiseit/views/campgain/campgain_screen.dart';
import 'package:raiseit/views/donations/my_donations_screen.dart';
import 'package:raiseit/views/home_screen/categories_card.dart';
import 'package:raiseit/views/home_screen/home_header.dart';
import 'package:raiseit/views/profile_screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  String _selectedFilter = 'All';
  bool _isAscending = true;

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

  Stream<List<Charity>> _fetchFilteredCharities() {
    Query query = FirebaseFirestore.instance.collection('charities');

    if (_selectedFilter == "Trending") {
      query = query.where('status', isEqualTo: 'Trending');
    } else if (_selectedFilter == "Urgency") {
      query = query.where('status', isEqualTo: 'Urgent');
    } else if (_selectedFilter == "Target Amount") {
      query = query.orderBy('targetAmount', descending: !_isAscending);
    } else if (_selectedFilter == "Amount Raised") {
      query = query.orderBy('raisedAmount', descending: !_isAscending);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Charity.fromFirestore(doc)).toList());
  }

  void _showFilterMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Filter Options",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Column(
                children: [
                  _buildFilterOption("All"),
                  _buildFilterOption("Trending"),
                  _buildFilterOption("Urgency"),
                  _buildFilterOption("Target Amount"),
                  _buildFilterOption("Amount Raised"),
                ],
              ),
              const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Sort Order", style: TextStyle(fontSize: 16)),
              ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                isSelected: [_isAscending, !_isAscending],
                onPressed: (index) {
                  setState(() {
                    _isAscending = index == 0;
                  });
                  Navigator.pop(context);
                },
                children: const [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("↑ Asc")),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("↓ Desc")),
                ],
              ),
            ],
          ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String filterName) {
    return ListTile(
      title: Text(filterName),
      trailing: _selectedFilter == filterName
          ? const Icon(Icons.check, color: Colors.blue)
          : null,
      onTap: () {
        setState(() {
          _selectedFilter = filterName;
        });
        Navigator.pop(context);
      },
    );
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
                      _buildFilterAndCharities(),
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

  Widget _buildFilterAndCharities() {
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

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: StreamBuilder<List<Charity>>(
            stream: _fetchFilteredCharities(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No charities found."));
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, index) {
                  Charity charity = snapshot.data![index];
                  return Card(
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
                            child: Image.network(
                              charity.imageUrl,
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
                          LinearProgressIndicator(
                            value: charity.raisedAmount / charity.targetAmount,
                            backgroundColor: Colors.grey[300],
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
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
