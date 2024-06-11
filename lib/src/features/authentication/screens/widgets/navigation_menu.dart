import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/forum/forum_screen.dart';
import 'package:fyp/src/features/authentication/screens/meditation/meditation_screen.dart';
import 'package:fyp/src/features/authentication/screens/profile/profile_screen_menu.dart';
import 'package:fyp/src/features/authentication/screens/resources/resources_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
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
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]), // Use Obx here
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 3.obs; // Set default to 0 if you want the first screen to be shown initially

  final screens = [
    const ResourcesScreen(),
    const MeditationScreen(),
    const ForumScreen(),
    const ProfileScreenMenu(),
  ];
}
