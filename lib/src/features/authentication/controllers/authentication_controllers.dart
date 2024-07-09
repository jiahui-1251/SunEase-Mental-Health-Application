import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final userName = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  var UserType = ''.obs;
  final userRepo = Get.put(UserRepository());

   void signUserUp(BuildContext context) async {
    // Ensure the context is still valid for showing dialogs
    if (context.mounted) {
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
    }

    try {
      if (password.text == confirmPassword.text) {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        String? userId = userCredential.user?.uid;

        if (userId != null) {
          UserModel newUser = UserModel(
            UserID: userId,
            UserName: userName.text,
            email: email.text,
            password: password.text,
            UserType: UserType.value,
          );

          await userRepo.createUser(newUser);

          if (context.mounted) Navigator.pop(context); // Close progress indicator

          // Redirect to login screen
          Get.offAll(() => const LoginScreen());
        } else {
          if (context.mounted) Navigator.pop(context); // Close progress indicator
          showErrorMessage(context, "Failed to retrieve user ID");
        }
      } else {
        if (context.mounted) Navigator.pop(context); // Close progress indicator
        showErrorMessage(context, "Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) Navigator.pop(context); // Close progress indicator
      showErrorMessage(context, e.message ?? "Unknown error occurred");
    } catch (e) {
      if (context.mounted) Navigator.pop(context); // Close progress indicator
      showErrorMessage(context, "An unexpected error occurred");
      print(e); // Log any unexpected errors
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

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

Future<void> deleteAccount(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Show loading dialog before starting the async operation
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          },
        );
      }

      // Delete user data from Firestore
      await userRepo.deleteUser(user.uid);

      // Delete user authentication
      await user.delete();

      // Hide loading dialog and redirect to login screen
      if (context.mounted) {
        Navigator.of(context).pop(); // Close the loading dialog
        Get.offAll(() => const LoginScreen());
      }
    }
  } on FirebaseAuthException catch (e) {
    // Hide loading dialog and show error message
    if (context.mounted) {
      Navigator.of(context).pop(); // Close the loading dialog
      showErrorMessage(context, e.message ?? "Unknown error occurred");
    }
  } catch (e) {
    // Hide loading dialog and show unexpected error message
    if (context.mounted) {
      Navigator.of(context).pop(); // Close the loading dialog
      showErrorMessage(context, "An unexpected error occurred");
      print(e); // Log any unexpected errors
    }
  }
}
}
