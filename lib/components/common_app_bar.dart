import 'package:flutter/material.dart';
import '../configs/colors.dart';

AppBar CommonAppBar() {
  return AppBar(
    title: Row(
      children: [
        Image.asset(
          'assets/img/logo2.png',
          width: 40.0,
        ),
        SizedBox(width: 8.0),
        Text('Mediplan+', style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w700
        )
      )
      ],
    ),
  );
}