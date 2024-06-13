import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:fyp/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  //Repositories
  final _authRepo = Get.find<AuthenticationRepository>();
  final _userRepo = Get.find<UserRepository>();

  //Get User Email and pass to user repository to fetch user record

  Future getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
      return Future.error("Login to continue");
    }
  }

  //Fetch List of user repositories
  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUser();

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }

}
