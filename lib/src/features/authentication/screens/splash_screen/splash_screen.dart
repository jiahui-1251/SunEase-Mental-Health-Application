import 'package:flutter/material.dart';
import 'package:fyp/pages/login_or_register_page.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/splash_screen_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  //Find SplashScreen Controller
  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx( () => AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                //can be writen as animate ? 0: -30
                top: splashController.animate.value ? 0: -30,
                left: splashController.animate.value ? 0: -30,
                right: splashController.animate.value ? 0: -30,
                bottom: splashController.animate.value ? 0: -30,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity: splashController.animate.value ? 1 : 0,
                  child: Image(
                    image: AssetImage(testingImage), width: 50, height: 50,),
                ),
              ),
            ),
            Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 1000),
                top: 80,
                left: splashController.animate.value ? tDefaultSize : -50,
                child: Column(
                  //Place the children with their start edge aligned with the start side of the cross axis.
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text(tAppName, style: Theme.of(context).textTheme.titleMedium),
                    Text(tAppTagLine, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   top: 100,
            //   child: Image(image: AssetImage(tSplashImage)),
            // ),

            //THIS CONTAINER NOT APPEARING ON SCREEN!
            Positioned(
                bottom: 40,
                right: tDefaultSize,
                child: Container(
                  width: tSplashContainerSize,
                  height: tSplashContainerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: tOrangeColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}