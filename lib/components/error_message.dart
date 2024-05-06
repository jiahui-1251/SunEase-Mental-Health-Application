import 'package:flutter/material.dart';

class ErrorMessages {
  static void invalidCredentialMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Email or Password'),
        );
      },
    );
  }

  static void tooManyAttemptMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Too many failed login attempts. \n Please try again later.'),
        );
      },
    );
  }

  static void emptyInputMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Empty input. Please try again.'),
        );
      },
    );
  }

  static void unknownErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Unknown error. Please try again.'),
        );
      },
    );
  }
}