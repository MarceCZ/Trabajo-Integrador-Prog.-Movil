import 'package:flutter/material.dart';
import '../configs/colors.dart';

class CustomFilterButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomFilterButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grisclarito, // Fondo gris claro
        borderRadius: BorderRadius.circular(30), // Bordes redondeados
      ),
      padding: EdgeInsets.only(left: 20, right: 15),
      height: 40, // Altura del botón
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black, // Texto negro
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            Spacer(), // Espacio entre el texto y el ícono
            Icon(
              Icons.arrow_drop_down, // Ícono de flecha
              color: Colors.black,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
