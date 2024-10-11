import 'package:flutter/material.dart';

class CustomTextLabel extends StatelessWidget {
  final String label;
  final String text;

  const CustomTextLabel({
    Key? key,
    required this.label,
    required this.text,
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
        Padding(padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
    ]);
  }
}