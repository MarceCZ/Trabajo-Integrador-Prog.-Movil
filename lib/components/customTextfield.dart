import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool? obscureText;

  const Customtextfield({
    Key? key,
    required this.label,
    this.hintText,
    this.inputType = TextInputType.text,
    this.controller,
    this.obscureText,
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
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          ),
        ),
    ]);
  }
}