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
  final double chipFontSize;

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
    required this.chipFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
            const SizedBox(height: 10.0),
            Text(
              description,
              style: const TextStyle(
                fontSize: 10.0,
                color: Color.fromARGB(255, 117, 117, 117),
              ),
            ),
            // Título del producto
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
            const SizedBox(height: 2.0),
            // Chip personalizado
            CustomChip(
              label: chipLabel,
              textColor: chipTextColor,
              backgroundColor: chipBackgroundColor,
              onTap: onChipTap,
              fontSize: chipFontSize,
            ),
            const Spacer(),
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
                    color: Color(0xFF1B986E),
                  ),
                  iconSize: 35.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
