import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/shopping_cart_controller.dart';
import 'package:mediplan/models/producto_botica.dart';
import '../../configs/colors.dart';

class ShoppingCartBottomSheet extends StatelessWidget {
  final ShoppingCartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mi kit',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Divider(),
          Obx(() {
            if (cartController.cartItems.isEmpty) {
              return Center(child: Text('No hay productos en el carrito'));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final ProductoBotica producto = cartController.cartItems[index];
                  return ListTile(
                    leading: Image.network(producto.imagen, width: 50, height: 50),
                    title: Text('${producto.nombre} | ${producto.marca}'),
                    subtitle: Text('S/ ${producto.precio.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        cartController.removeItem(producto);
                      },
                    ),
                  );
                },
              );
            }
          }),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Lógica para continuar con la compra
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: AppColors.primaryColor,
            ),
            child: Text('Continuar'),
          ),
        ],
      ),
    );
  }
}