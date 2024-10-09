import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  const CustomChip({
    Key? key,
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 11.0, // Ajusta el tamaño de la fuente
            fontWeight: FontWeight.bold, // Negrita para mayor legibilidad
          ),
        ),
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.0), // Ajusta el padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0), // Bordes redondeados
          side: BorderSide(color: backgroundColor), // Borde gris claro
        ),
      ),
    );
  }
}
