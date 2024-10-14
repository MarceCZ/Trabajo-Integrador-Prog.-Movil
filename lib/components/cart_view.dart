import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/configs/colors.dart';
import 'cart_controller.dart';
import 'package:mediplan/components/product_tile.dart';
import 'package:mediplan/components/button.dart';

class CartView extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.5,  // Ocupa la mitad de la altura de la pantalla
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Stack(
        children: [
          // Lista de productos en el carrito
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),  // Reservar espacio para el botón
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
                const SizedBox(height: 10.0),
                Obx(() {
                  if (cartController.cartItems.isEmpty) {
                    return Center(child: Text('Agrega productos al kit'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
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
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
          // Mostrar el botón "Continuar" solo si hay productos en el carrito
          Obx(() {
            return cartController.cartItems.isNotEmpty
                ? Positioned(
                    bottom: 0.0,  // Mueve el botón 20 píxeles hacia arriba del borde inferior
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Button(
                        title: 'Continuar',
                        onPressed: () {
                          // Acción para navegar a la página de productos del kit
                          Navigator.pushNamed(context, '/kit-products');
                        },
                        width: double.infinity,  // Ocupa todo el ancho disponible
                        height: 50.0,
                      ),
                    ),
                  )
                : SizedBox.shrink();  // No mostrar nada si el carrito está vacío
          }),
        ],
      ),
    );
  }
}