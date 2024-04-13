import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  const MyInputField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
  });

  final String? hintText;
  final IconData icon;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        hintText: hintText.toString(),
        hintStyle: const TextStyle(color: Colors.black45),
        fillColor: Colors.white,
        prefixIcon: Icon(
          icon,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),

        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
      ),
    );
  }
}
