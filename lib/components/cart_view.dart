import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/product_tile.dart';
import 'package:mediplan/configs/colors.dart';
import 'cart_controller.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/product_tile.dart';

class CartView extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Mi kit',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          Obx(() {
            if (cartController.cartItems.isEmpty) {
              return Text('El carrito está vacío');
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final producto = cartController.cartItems[index];
                  return ProductTile(
                    imagen: producto.imagen,
                    nombre: producto.nombre,
                    marca: producto.marca,
                    precio: producto.precio,
                    requiereReceta: producto.requiereReceta,
                    cartController: cartController,
                  );
                },
              );
            }
          }),
          const SizedBox(height: 16.0),
          Button(
              title: 'Continuar',
              onPressed: () {
              // Navega a la página del carrito
              Navigator.pushNamed(context, '/kit-products');
            },
              width: double.infinity,
              height: 50.0),
        ],
      ),
    );
  }
}