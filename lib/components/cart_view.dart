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
      height: screenHeight * 0.5,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Stack(
        children: [
          // Lista de productos en el carrito
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
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
                    return Center(child: Text('¡Agrega productos al kit!'));
                  } else {
                    final Set<int> uniqueProductIds = Set();
                    final uniqueProducts =
                        cartController.cartItems.where((producto) {
                      if (!uniqueProductIds.contains(producto.id)) {
                        uniqueProductIds.add(producto.id);
                        return true;
                      }
                      return false;
                    }).toList();

                    return Expanded(
                      child: ListView.builder(
                        itemCount: uniqueProducts.length,
                        itemBuilder: (context, index) {
                          final producto = uniqueProducts[index];
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
                    bottom: 0.0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Button(
                        title: 'Continuar',
                        onPressed: () {
                          Navigator.pushNamed(context, '/kit-products');
                        },
                        width: double.infinity,
                        height: 50.0,
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ),
                  )
                : SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}