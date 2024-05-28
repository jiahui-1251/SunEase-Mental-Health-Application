import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight -10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            //Email
            TextFormField(
              decoration: const InputDecoration(
                label: Text(tEmail),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: tOrangeColor,
                ),
                labelStyle: TextStyle(color: tBlackColor),
              )
            ),

            const SizedBox(height: tFormHeight),
            
            //Password
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                label: Text(tPassword),
                prefixIcon: Icon(
                  Icons.fingerprint_outlined,
                  color: tOrangeColor,
                ),
                labelStyle: TextStyle(color: tBlackColor),
              )
            ),

            const SizedBox(height: tFormHeight-20),

            //Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(tForgotPassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){}, 
                child: Text(tLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}