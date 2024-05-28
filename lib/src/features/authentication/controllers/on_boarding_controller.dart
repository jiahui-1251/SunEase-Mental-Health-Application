import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/models/model_on_boarding.dart';
import 'package:fyp/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

class OnBoardingController extends GetxController {
  
  final LiquidController _controller = LiquidController();
  //To convert stateful widget (setState) to getX we use .obs on values, and Rx on datatype
  RxInt _currentPage = 0.obs;

    final pages = [
      OnBoardingPageWidget(
        key: UniqueKey(),
        model: OnBoardingModel(
          image: tOnBoardingImage1,
          title: tOnBoardingTitle1,
          subTitle: tOnBoardingSubTitle1,
          counterText: tOnBoardingCounter1,
          bgColor: tOnBoardingPage1Color,
        ),
      ),
      OnBoardingPageWidget(
        key: UniqueKey(),
        model: OnBoardingModel(
          image: tOnBoardingImage2,
          title: tOnBoardingTitle2,
          subTitle: tOnBoardingSubTitle2,
          counterText: tOnBoardingCounter2,
          bgColor: tOnBoardingPage2Color,
        ),
      ),
    ];
    
    void onPageChangedCallback(int activePageIndex) =>  _currentPage.value = activePageIndex;
    skip() {
      Get.to(WelcomeScreen());
    }

    // void onPageChangedCallback(int activePageIndex) {
    //   _currentPage.value = activePageIndex;
    //   if (activePageIndex == pages.length - 1) {
    //     // Jump to welcome screen on last page
    //     Get.to(WelcomeScreen());
    //   }
    // }

    // animateToNextSlide(){
    //   final nextPage = _controller.currentPage + 1;
    //   _controller.animateToPage(page: nextPage);
    // }

    animateToNextSlide(){
      final nextPage = _controller.currentPage + 1;
      if (nextPage < pages.length) {
        _controller.animateToPage(page: nextPage);
      } else {
        // Handle last page - Navigate to welcome screen
        Get.to(WelcomeScreen());
      }
    }

    LiquidController get controller => _controller; // Public getter
    RxInt get currentPage => _currentPage;
}