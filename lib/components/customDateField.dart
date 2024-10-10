import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final Function()? onCalendarTap;

  const CustomDateField({
    Key? key,
    required this.label,
    this.hintText,
    required this.controller,
    required this.onCalendarTap, 
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
          readOnly: true,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: onCalendarTap,
              )
            )
          ),
        ),
      ],
    );
  }
}
