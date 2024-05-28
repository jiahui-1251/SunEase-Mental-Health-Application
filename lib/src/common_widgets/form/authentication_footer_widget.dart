import 'package:flutter/material.dart';
import 'package:fyp/src/constants/sizes.dart';

class AuthenticationFooterWidget extends StatelessWidget {
  const AuthenticationFooterWidget({
    super.key,
    required this.caption,
    required this.buttonText,
    required this.onPressed,
  });

  final String caption, buttonText; 
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const SizedBox(height: tFormHeight - 20);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(caption),
          
        TextButton(
          onPressed: onPressed, 
          child: Text(buttonText),
          ),
      ],
    );
  }
}