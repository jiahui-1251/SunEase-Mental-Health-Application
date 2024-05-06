import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller; //To access what user have type in textfield
  final String hintText;
  final bool obscureText;
  
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText, //Bool variable to hide password when user entering passwords
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])
        ),
      ),
    );
  }
}