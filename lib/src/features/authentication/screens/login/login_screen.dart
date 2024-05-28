import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/form/authentication_footer_widget.dart';
import 'package:fyp/src/common_widgets/form/form_header_widget.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/login/login_form_widget.dart';
import 'package:fyp/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView( //Enable scrolling & prevent buffer overflow error
          child: Container(
            padding: EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Image(image: AssetImage(tWelcomeImage)),
                FormHeaderWidget(image: tWelcomeImage, title: tLoginTitle, subTitle: tLoginSubTitle),

                LoginForm(),

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     const Text("OR"),
                //     SizedBox(
                //       child: OutlinedButton.icon(
                //         icon: Image(image: AssetImage(tGoogleLogoImage), width: 20.0),
                //         onPressed: () {},
                //         label: Text(tSignInWithGoogle),  
                //       ),
                //     )
                //   ],
                // ),
                
                AuthenticationFooterWidget(
                  caption: tNotAMember, 
                  buttonText: tRegisterNow,
                  onPressed: () => Get.to(() => const SignUpScreen()),
                ),
                // login_footer_widget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}




