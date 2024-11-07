import 'package:flutter/material.dart';
import '../configs/colors.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? size;

  const FloatingButton({
    Key? key,
    required this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 85.0,
      height: size ?? 85.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? AppColors.secondaryColor,
         boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          Icons.medical_services,
          color: iconColor ?? Colors.white,
          size: (size ?? 85.0) * 0.5,
        ),
        onPressed: onPressed,
      ),
    );
  }
}