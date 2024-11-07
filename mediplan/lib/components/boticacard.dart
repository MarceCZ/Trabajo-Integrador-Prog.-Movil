import 'package:flutter/material.dart';

class BoticaCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int productCount;
  final VoidCallback onTap;

  const BoticaCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.productCount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen de la botica
              Container(
              height: 150.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
              const SizedBox(height: 10.0),
              // Nombre de la botica
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 5.0),
              // Cantidad de productos disponibles
              Text(
                '$productCount productos disponibles',
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Color.fromARGB(255, 117, 117, 117),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
