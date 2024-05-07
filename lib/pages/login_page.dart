import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_button.dart';
import 'package:fyp/components/my_textfield.dart';
// import 'package:fyp/components/square_tile.dart';
// import 'package:fyp/components/error_message.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
    void signUserIn() async{
      //show loading circle
      showDialog(context: context, 
      builder: (context){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      );

      //try sign in
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text,
        );
        
        //pop the loading circle
        Navigator.pop(context);

      } on FirebaseAuthException catch (e) {
        //pop the loading circle
        Navigator.pop(context);

        //show error message
        showErrorMessage(e.code + ". \nPlease try again!");
      }
  }

  //Error message popup
  void showErrorMessage(String message){
    showDialog(
      context: context, 
      builder:(context){
      return AlertDialog(
        backgroundColor: Colors.deepOrange,
        title: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          )),
      );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const SizedBox(height: 10),
              
              //logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
            
              const SizedBox(height: 20),
              
              //welcome back, you'have been missed
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
            
              const SizedBox(height: 20),
              
              //email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
            
              const SizedBox(height: 10),
            
              //password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
            
              const SizedBox(height: 10),
            
              //forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            
              const SizedBox(height: 15),
            
              //sign in  button
              MyButton(
                text: "Sign In",
                onTap: signUserIn,
              ),
            
              const SizedBox(height: 20),
            
              // //or continue with
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child:  Divider(
              //           thickness: 0.5,
              //           color: Colors.grey[400],
              //         ),
              //       ),
                
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //         child: Text(
              //           'Or continue with',
              //           style: TextStyle(color: Colors.grey[700]),  
              //         ),
              //       ),
                
              //       Expanded(
              //         child:  Divider(
              //           thickness: 0.5,
              //           color: Colors.grey[400],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            
              // const SizedBox(height: 20),
            
              // //google sign in button
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //       SquareTile(imagePath: 'lib/images/google.png'),
              //   ],
              // ),
            
              const SizedBox(height: 50),
            
              //not a member? register now
            
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register now', 
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              
              )
            ],),
          ),
        ),
      )
    );
  }
}