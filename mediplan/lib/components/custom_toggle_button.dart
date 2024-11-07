import 'package:flutter/material.dart';
import '../configs/colors.dart';

class CustomToggleButton extends StatelessWidget {
  final String title;
  final int selectedIndex;
  final int buttonIndex;
  final VoidCallback onPressed;

  const CustomToggleButton({
    Key? key,
    required this.title,
    required this.selectedIndex,
    required this.buttonIndex,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedIndex == buttonIndex;

    return SizedBox(
      width: 180.0, // Ancho fijo para el botón
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? AppColors.primaryColor : AppColors.backgroundColor,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          elevation: isSelected ? 3 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
