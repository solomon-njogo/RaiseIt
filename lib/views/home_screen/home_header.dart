import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raiseit/viewmodels/profile_viewmodel.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600 && screenWidth <= 900;
    final isDesktop = screenWidth > 900;

    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, child) {
        final user = profileViewModel.user;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 32.0 : isTablet ? 24.0 : 16.0,
            vertical: isDesktop ? 20.0 : 12.0,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: isDesktop ? 40 : isTablet ? 35 : 30,
                backgroundImage: const AssetImage('assets/images/3d-cartoon-character-b.png'),
              ),
              SizedBox(width: isDesktop ? 16 : 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isDesktop ? 20 : isTablet ? 18 : 16,
                    ),
                  ),
                  Text(
                    user?.name ?? "User",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isDesktop ? 26 : isTablet ? 24 : 22,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: isDesktop ? 34 : isTablet ? 32 : 30,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
