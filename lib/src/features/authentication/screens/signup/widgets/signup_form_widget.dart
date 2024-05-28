import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/form/privacy_policy.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight -20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
    
            //User Name
            TextFormField(
              decoration: const InputDecoration(
                label: Text(tUserName),
                prefixIcon: Icon(
                  Icons.person_outline_rounded,
                  color: tOrangeColor,
                ),
                labelStyle: TextStyle(color: tBlackColor),
              )
            ),
    
            const SizedBox(height: tFormHeight - 20),
    
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
    
            const SizedBox(height: tFormHeight - 20),                        
    
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
    
            const SizedBox(height: tFormHeight - 30),

            //Privacy Policy
            PrivayPolicy(),

            //SignUp Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){}, 
                child: Text(tSignup.toUpperCase()),
              ),
            ),
          ]
        )
      )
    );
  }
}