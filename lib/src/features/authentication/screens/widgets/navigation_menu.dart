import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [

          NavigationDestination(
            icon: Icon(Iconsax.search_normal),
            label: 'Resources',
          ),
          NavigationDestination(
            icon: Icon(Iconsax.emoji_happy),
            label: 'Meditation',
          ),
          NavigationDestination(
            icon: Icon(Iconsax.people),
            label: 'Forum',
          ),          
          NavigationDestination(
            icon: Icon(Iconsax.profile_add),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}