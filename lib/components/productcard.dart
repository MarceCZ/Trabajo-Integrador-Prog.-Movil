import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final VoidCallback onAddPressed;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Título del producto
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 4.0),
            // Descripción del producto
            Text(
              description,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            // Precio y botón de agregar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'S/ ${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: onAddPressed,
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}