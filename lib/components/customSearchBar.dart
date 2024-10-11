import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String placeholder;
  final ValueChanged<String> onChanged;

  const CustomSearchBar({
    Key? key, 
    required this.placeholder,
    required this.onChanged,
    }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.0,
        child: TextField(
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          onChanged: onChanged,
        ),
      );
  }
}
