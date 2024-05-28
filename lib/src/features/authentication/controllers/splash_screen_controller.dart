import 'package:flutter/material.dart';
import 'package:fyp/pages/login_or_register_page.dart';
import 'package:fyp/src/features/authentication/controllers/on_boarding_controller.dart';
import 'package:fyp/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';

//GetxController is used for state management
class SplashScreenController extends GetxController {

  //initialize the instance
  static SplashScreenController get find => Get.find();

  //RxBool, used with .obs (observable) such that whenever the variable is used / change it will affected to all screen
  //RxBool is a getx boolean
  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(Duration(seconds: 1)); 
    Get.to(OnBoardingScreen());
  } 
}