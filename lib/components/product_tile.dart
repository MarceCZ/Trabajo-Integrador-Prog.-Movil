import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/customchip.dart';
import 'cart_controller.dart'; // Asegúrate de que esto está importado correctamente

class ProductTile extends StatelessWidget {
  final String imagen;
  final String nombre;
  final String marca;
  final double precio;
  final bool requiereReceta;
  final CartController cartController;

  const ProductTile({
    Key? key,
    required this.imagen,
    required this.nombre,
    required this.marca,
    required this.precio,
    required this.requiereReceta,
    required this.cartController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        leading: Image.network(imagen, width: 50),
        title: Text(
          '$nombre | $marca',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'S/ $precio',
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 8.0), // Espacio entre el precio y el Row
            Row(
              children: [
                // Chip "REQUIERE RECETA" alineado a la izquierda
                if (requiereReceta) ...[
                  CustomChip(
                    label: 'REQUIERE RECETA',
                    textColor: Colors.black,
                    backgroundColor: Color(0xFFCCCCCC),
                    fontSize: 9,
                    onTap: () {
                      print('Chip de Requiere Receta presionado');
                    },
                  ),
                ],
                Spacer(),
                // Botones de agregar y quitar alineados a la derecha
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline,
                          color: Colors.black),
                      onPressed: () {
                        cartController.removeFromCart(cartController.cartItems
                            .firstWhere((item) =>
                                item.nombre ==
                                nombre)); // Asegúrate de que la lógica para quitar el producto es correcta
                      },
                    ),
                    Obx(() {
                      final cantidad = cartController.getProductCount(nombre);
                      return Text(
                        '$cantidad', // Muestra la cantidad actual
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      );
                    }),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline, color: Colors.black),
                      onPressed: () {
                        cartController.addToCart(cartController.cartItems
                            .firstWhere((item) =>
                                item.nombre ==
                                nombre)); // Asegúrate de que la lógica para agregar el producto es correcta
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}