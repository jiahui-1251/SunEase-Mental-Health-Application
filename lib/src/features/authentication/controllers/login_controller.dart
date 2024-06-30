import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/profile/profile_screen_menu.dart';
import 'package:fyp/src/features/authentication/screens/widgets/navigation_menu.dart';
import 'package:get/get.dart';

class LoginControllers extends GetxController {
  static LoginControllers get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  void loginUser(BuildContext context) async {
    // Show loading circle with custom color
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        );
      },
    );

    // Try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      
      // Pop the loading circle
      Navigator.pop(context);

      // Navigate to ProfileScreenMenu
      Get.to(() => const NavigationMenu());

    } on FirebaseAuthException catch (e) {
      // Pop the loading circle
      Navigator.pop(context);

      // Show error message
      showErrorMessage(context, e.message ?? "Unknown error occurred. Please try again!");
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepOrange,
          title: Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
