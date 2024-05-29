import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/form/form_header_widget.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              const SizedBox(height: tDefaultSize * 4),
              const FormHeaderWidget(
                image: tForgetPasswordImage, 
                title: tForgotPasswordTitle, 
                subTitle: tForgotPasswordSubTitle,
                heightBetween: 30.0,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: tFormHeight),
              Form(child: 
              
                Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(tEmail),
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                          color: tOrangeColor,
                        ),
                        labelStyle: TextStyle(color: tBlackColor),
                      )
                    ),

                    const SizedBox(height: 20.0),

                    SizedBox(
                      width: double.infinity, 
                      child: ElevatedButton(
                        onPressed: ()=> Get.to(() => const OTPScreen()), 
                        child: const Text(tNext)
                      )
                    ),
                  ],
                )
              )
            ]
          )
        ),
      )
    );
  }
}