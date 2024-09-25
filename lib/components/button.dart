import 'package:flutter/material.dart';

import '../configs/colors.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;

  const Button({
    Key? key,
    required this.title,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.borderRadius,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColor ?? AppColors.secondaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(30),
            )
          )
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 25.0,
          ) 
        ),
        ),
    );
  }
}