import 'package:flutter/material.dart';
import 'package:fyp/pages/login_or_register_page.dart';
import 'package:fyp/pages/register_page.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: tWhiteColor,
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage(tWelcomeImage), height: height*0.5),
            Column(
              children: [
                Text(
                  tWelcomeTitle,
                  style: Theme.of(context).textTheme.titleMedium, 
                ),
                Text(
                  tWelcomeSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ]
            ),
            Row(
              children: [
                Expanded( //Expanded class resize widget dynamically
                  child: OutlinedButton(
                    onPressed: () => Get.to(() => const LoginScreen()),
                    // {
                    //   Get.to(LoginOrRegisterPage());
                    // }, 
                    child: Text(tLogin.toUpperCase())
                  ),
                ),
                SizedBox(width: 10.0,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const SignUpScreen()),
                    child: Text(tSignup.toUpperCase())
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}