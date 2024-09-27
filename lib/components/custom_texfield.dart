import 'package:flutter/material.dart';

class CustomTexfield extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType? inputType;
  final TextEditingController controller;
  final bool obscureText;

  const CustomTexfield({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.inputType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: inputType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          ),
        ),
      ],
    );
  }
}