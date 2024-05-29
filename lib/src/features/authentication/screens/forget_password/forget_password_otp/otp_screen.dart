import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tOtpTitle,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
              )
            ),
            Text(
              tOtpSubtitle.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall,
            ),

            const SizedBox(height: 40.0),

            Text(
              tOtpMessage + "testing@gmail.com",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20.0),

            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code){ print("OTP is => $code");},
            ),

            const SizedBox(height: 20.0),

            SizedBox(
              width: double.infinity, 
              child: ElevatedButton(
                onPressed: () {}, 
                child: const Text(tNext)
               )
            ),
          ],
        ),
      ),
    );
  }
}