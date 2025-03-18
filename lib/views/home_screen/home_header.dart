import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raiseit/viewmodels/profile_viewmodel.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, child) {
        final user = profileViewModel.user;

        return Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/3d-cartoon-character-b.png'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome,",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  user?.name ?? "User ", // Display user's name or a placeholder
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, size: 30),
            ),
          ],
        );
      },
    );
  }
}
