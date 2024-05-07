import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pages/home_page.dart';
import 'package:fyp/pages/login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), //constantly listen to firebase auth on user login
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData){
            return HomePage();
          }

          //user is NOT logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      )
    );
  }
}