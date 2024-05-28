import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_button.dart';
import 'package:fyp/components/my_textfield.dart';
// import 'package:fyp/components/square_tile.dart';
// import 'package:fyp/components/error_message.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController(); 
  bool? isChecked = false;

  //sign user up method
    void signUserUp() async{
      //show loading circle
      showDialog(context: context, 
      builder: (context){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      );

      //try creating user
      try{
        //check if password is confirmed
        if(passwordController.text == confirmPasswordController.text){
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, 
            password: passwordController.text,
          );
        } else {
          //show error message, passwords don't match
          showErrorMessage("Password don't match");
        }
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
                size: 50,
              ),
            
              const SizedBox(height: 20),
              
              //Welcome message
              Text(
                'Let\'s create an account for you!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
            
              const SizedBox(height: 20),
              
              //username textfield
              MyTextField(
                controller: userNameController,
                hintText: 'User Name',
                obscureText: false,
              ),

              const SizedBox(height: 10),

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

              //confirm password textfield
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
            
              //Terms and conditions
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       const PrivacyPolicy(),
              //     ],
              //   ),
              // ),
            
              const SizedBox(height: 10),
            
              //sign in  button
              MyButton(
                text: "Sign Up",
                onTap: signUserUp,
              ),
            
              const SizedBox(height: 10),
            
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
            
              // const SizedBox(height: 10),
            
              // //google sign in button
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //       SquareTile(imagePath: 'lib/images/google.png'),
              //   ],
              // ),
            
              const SizedBox(height: 10),
            
              //not a member? register now
            
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login now', 
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