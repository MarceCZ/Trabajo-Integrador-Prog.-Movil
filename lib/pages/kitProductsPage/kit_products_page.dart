import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/cart_controller.dart';
import 'package:mediplan/components/product_tile.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/common_app_bar.dart';
import 'package:mediplan/configs/colors.dart';
import 'package:mediplan/components/stepProgress.dart';
import 'package:mediplan/pages/kitProductsPage/kit_products_controller.dart';

class KitProductsPage extends StatelessWidget {
  final KitProductsController kitProductsController =
      Get.put(KitProductsController());
  final CartController cartController = Get.find<CartController>();

  @override
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    "Mi kit",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  StepProgress(currentStep: 1),
                  SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Obx(() {
                              if (cartController.cartItems.isEmpty) {
                                return Center(
                                    child: Text('Agrega productos al kit'));
                              } else {
                                // Reemplazar ListView con Column
                                return Column(
                                  children:
                                      cartController.cartItems.map((producto) {
                                    return ProductTile(
                                      imagen: producto.imagen,
                                      nombre: producto.nombre,
                                      marca: producto.marca,
                                      precio: producto.precio,
                                      requiereReceta: producto.requiereReceta,
                                      cartController: cartController,
                                    );
                                  }).toList(),
                                );
                              }
                            }),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Obx(() {
                          return Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Subtotal: ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  Text(
                                    'S/ ${kitProductsController.subtotal}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ],
                              )
                          );
                        }),
                        SizedBox(height: 5.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Button(
                    title: 'Continuar',
                    onPressed: () {
                      // Validar el formulario al presionar el botón
                      if (cartController.cartItems.isNotEmpty) {
                        Navigator.pushNamed(context, '/kit-delivery');
                      } else  Get.snackbar("Error", "No hay productos.");
                    },
                    width: 200.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: _buildBody(context),
      resizeToAvoidBottomInset: true,
    );
  }
}