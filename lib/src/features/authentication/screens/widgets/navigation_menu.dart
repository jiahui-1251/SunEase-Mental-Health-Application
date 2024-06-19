import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/features/authentication/screens/forum/forum_screen.dart';
import 'package:fyp/src/features/authentication/screens/meditation/meditation_screen.dart';
import 'package:fyp/src/features/authentication/screens/profile/profile_screen_menu.dart';
import 'package:fyp/src/features/authentication/screens/resources/resources_screen.dart';
import 'package:fyp/src/features/authentication/screens/daily/daily_screen.dart'; // Import the DailyScreen
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Container(
            height: 70, // Adjust the height to lower the notch
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildNavItem(Iconsax.search_normal, 'Resources', 0, controller),
                buildNavItem(Iconsax.emoji_happy, 'Meditation', 1, controller),
                SizedBox(width: 40), // The middle space for the FAB
                buildNavItem(Iconsax.people, 'Forum', 2, controller),
                buildNavItem(Iconsax.profile_add, 'Profile', 3, controller),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: EllipticalFloatingActionButton(
        onPressed: () {
          controller.selectedIndex.value = 4;
        },
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(),
      body: Obx(() => controller.screens[controller.selectedIndex.value]), // Use Obx here
    );
  }

  Widget buildNavItem(IconData icon, String label, int index, NavigationController controller) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.selectedIndex.value = index,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: controller.selectedIndex.value == index ? tOrangeColor : tBlackColor),
            Text(
              label,
              style: TextStyle(
                color: controller.selectedIndex.value == index ? tOrangeColor : tBlackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 3.obs; // Set default to 3 for Profile screen initially

  final screens = [
    const ResourcesScreen(),
    const MeditationScreen(),
    const ForumScreen(),
    const ProfileScreenMenu(),
    const DailyScreen(), // Add the DailyScreen to the list of screens
  ];
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double notchHeight = scaffoldGeometry.minInsets.bottom;
    final double fabX = (scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width) / 2;
    final double fabY = scaffoldGeometry.scaffoldSize.height - scaffoldGeometry.floatingActionButtonSize.height - notchHeight - 40; // Adjust the height here
    return Offset(fabX, fabY);
  }
}

class EllipticalFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EllipticalFloatingActionButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50, // Width of the ellipse
        height: 50, // Height of the ellipse
        decoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Icon(Iconsax.calendar, color: Colors.white),
        ),
      ),
    );
  }
}
