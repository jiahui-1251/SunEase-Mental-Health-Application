import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/daily_challenges_model.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/user_challenges_model.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/repository/challenges_repository/daily_challenges_repository.dart';
import 'package:fyp/src/repository/challenges_repository/user_challenges_repository.dart';
import 'package:fyp/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final DailyChallengeRepository _dailyChallengeRepo = Get.put(DailyChallengeRepository());
  final UserChallengeRepository _userChallengeRepo = Get.put(UserChallengeRepository());

  // TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final userName = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  var UserType = ''.obs;
  final userRepo = Get.put(UserRepository());

  void signUserUp(BuildContext context) async {
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

    try {
      if (password.text == confirmPassword.text) {
        print('Email: ${email.text}, Password: ${password.text}');
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

          Navigator.pop(context);

          Get.to(() => const LoginScreen());
        } else {
          Navigator.pop(context);
          showErrorMessage(context, "Failed to retrieve user ID");
        }
      } else {
        Navigator.pop(context);
        showErrorMessage(context, "Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(context, e.message ?? "Unknown error occurred");
    } catch (e) {
      Navigator.pop(context);
      showErrorMessage(context, "An unexpected error occurred");
      print(e); // Log any unexpected errors
    }
  }

  Future<void> _initializeUserChallenges(String userId) async {
    List<DailyChallenge> allChallenges = await _dailyChallengeRepo.getDailyChallenges();
    allChallenges.shuffle();  // Randomize the list
    List<DailyChallenge> selectedChallenges = allChallenges.take(3).toList();

    UserChallenge userChallenge = UserChallenge(
      UserID: userId,
      ChallengeID: selectedChallenges.map((c) => c.ChallengeID).toList(),
      ChallengeStatus: List.filled(3, false),
      Date: Timestamp.now(),
      NumCompletion: 0,
    );

    await _userChallengeRepo.createUserChallenge(userChallenge);
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
        // Delete user data from Firestore
        await userRepo.deleteUser(user.uid);

        // Delete user authentication
        await user.delete();

        // Redirect to login screen
        Get.offAll(() => const LoginScreen());
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(context, e.message ?? "Unknown error occurred");
    }
  }
}
