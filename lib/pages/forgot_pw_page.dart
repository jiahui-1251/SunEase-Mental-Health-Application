import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:logger/logger.dart';

class ForgotPasswordPage extends StatefulWidget {
  
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final logger = Logger();
  final _emailController = TextEditingController();

  @override
  //dispose is used to release memory allocated to variables when state object is removed
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

Future<void> passwordReset() async {
  final _auth = FirebaseAuth.instance;

  try {
    await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
    // If no exception occurred, consider the password reset successful
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Password reset email has been sent to ${_emailController.text.trim()}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    print(e);
    String errorMessage = 'An error occurred. Please try again later.';
    // You can handle specific error types here if needed
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[400],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter your email and we will send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          
          const SizedBox(height: 10),

          //email textfield
          MyTextField(
            controller: _emailController,
            hintText: 'Email',
            obscureText: false,
          ), 

          const SizedBox(height: 10),

          MaterialButton(
            onPressed: passwordReset,
            child: Text('Reset Password'),
            color: Colors.deepOrange[200],

          ),         
        ],
      ),
    );
  }
}