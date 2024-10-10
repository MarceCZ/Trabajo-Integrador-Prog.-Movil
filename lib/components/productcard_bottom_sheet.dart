import 'package:flutter/material.dart';
import 'package:mediplan/components/customchip.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final VoidCallback onAddPressed;
  final String chipLabel;
  final Color chipTextColor;
  final Color chipBackgroundColor;
  final VoidCallback onChipTap;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.onAddPressed,
    required this.chipLabel,
    required this.chipTextColor,
    required this.chipBackgroundColor,
    required this.onChipTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            Container(
              height: 120.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 4.0),
            // Descripción del producto
            Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12.0,
                color: Color.fromARGB(255, 117, 117, 117),
              ),
            ),
            const SizedBox(height: 8.0),
            // Chip personalizado
            Align(
              alignment: Alignment.centerLeft,
              child: CustomChip(
                label: chipLabel,
                textColor: chipTextColor,
                backgroundColor: chipBackgroundColor,
                onTap: onChipTap,
              ),
            ),
            const Spacer(),
            // Precio y botón de añadir
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'S/ ${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B986E),
                  ),
                ),
                IconButton(
                  onPressed: onAddPressed,
                  icon: const Icon(
                    Icons.add_circle,
                    color: Color(0xFF1B986E),
                  ),
                  iconSize: 30.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}