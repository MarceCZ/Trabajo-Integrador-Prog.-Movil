import 'package:flutter/material.dart';
import 'package:mediplan/configs/colors.dart';

class StepProgress extends StatelessWidget {
  final int currentStep; // Paso actual (1, 2 o 3)

  StepProgress({required this.currentStep});

  // Paso estáticos
  final List<Map<String, String>> steps = [
    {'number': '1', 'title': 'Confirmar\nproductos'},
    {'number': '2', 'title': 'Detallar\nentrega'},
    {'number': '3', 'title': 'Confirmar\nsuscripción'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espaciado horizontal
      child: Center( // Centra todo el contenido en el centro
        child: Wrap(
          alignment: WrapAlignment.center, // Centra los elementos dentro del Wrap
          spacing: 30.0, // Espacio horizontal entre los pasos
          runSpacing: 10.0, // Espacio vertical entre los pasos
          children: List.generate(steps.length, (index) {
            // Generamos los pasos con su número y título
            int stepIndex = index;
            bool isActive = stepIndex + 1 == currentStep; // Solo el paso actual será verde
            return StepWidget(
              number: steps[stepIndex]['number']!,
              title: steps[stepIndex]['title']!,
              isActive: isActive,
            );
          }),
        ),
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  final String number;
  final String title;
  final bool isActive;

  StepWidget({
    required this.number,
    required this.title,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Evita que el tamaño de la columna sea mayor al necesario
      children: [
        CircleAvatar(
          radius: 18,  // Ajustado el tamaño del CircleAvatar
          backgroundColor: isActive ? AppColors.secondaryColor : Colors.grey,
          child: Text(
            number, 
            style: TextStyle(
              color: Colors.white,
              fontSize: 12, // Ajustado el tamaño del texto
            ),
          ),
        ),
        const SizedBox(height: 4),  // Espacio entre el CircleAvatar y el texto
        Text(
          title, 
          style: TextStyle(
            fontSize: 10,  // Reducido el tamaño del texto
          ),
          textAlign: TextAlign.center,  // Centra el texto debajo del CircleAvatar
        ),
      ],
    );
  }
}