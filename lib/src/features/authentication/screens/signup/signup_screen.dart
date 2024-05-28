import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/form/authentication_footer_widget.dart';
import 'package:fyp/src/common_widgets/form/form_header_widget.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView( //Enable scrolling & prevent buffer overflow error
          child: Container(
            padding: EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Image(image: AssetImage(tWelcomeImage)),
                FormHeaderWidget(image: tWelcomeImage, title: tSignUpTitle, subTitle: tSignUpSubTitle),

                SignUpFormWidget(),                

                AuthenticationFooterWidget(
                  caption: tAlreadyHaveAccount, 
                  buttonText: tLoginNow,
                  onPressed: () => Get.to(() => const LoginScreen()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




