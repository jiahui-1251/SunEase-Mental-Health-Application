import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final userName = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final userRepo = Get.put(UserRepository());

  Future <void> createUser(UserModel user, BuildContext context) async {
    await userRepo.createUser(user);
    signUserUp(context);
  }

  void signUserUp(BuildContext context) async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        );
      },
    );

    // Try creating user
    try {
      // Check if password is confirmed
      if (password.text == confirmPassword.text) {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        
        // Create UserModel instance
        UserModel newUser = UserModel(
          UserID: userCredential.user?.uid,
          UserName: userName.text,
          email: email.text,
          password: password.text,
        );

        // Store user data in Firestore
        // await UserRepository.instance.createUser(newUser);

        Navigator.pop(context); // Pop the loading circle

        Get.to(() => LoginScreen());
      } else {
        // Show error message, passwords don't match
        Navigator.pop(context); // Pop the loading circle
        showErrorMessage(context, "Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); 
      // Show error message
      showErrorMessage(context, e.message ?? "Unknown error occurred");
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
