import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/cart_controller.dart';
import 'package:mediplan/components/product_tile.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/commonAppBar/common_app_bar.dart';
import 'package:mediplan/configs/colors.dart';
import 'package:mediplan/components/stepProgress.dart';
import 'package:mediplan/pages/kitProductsPage/kit_products_controller.dart';
import '../../components/common_drawer.dart';
import 'package:mediplan/components/prescription_dialog.dart';

class KitProductsPage extends StatelessWidget {
  final KitProductsController kitProductsController =
      Get.put(KitProductsController());
  final CartController cartController = Get.find<CartController>();

  // Método para mostrar el popup de subir archivo
  void _showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PrescriptionDialog();
      },
    );
  }

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
                                final Set<int> uniqueProductIds = Set();
                                final uniqueProducts =
                                    cartController.cartItems.where((producto) {
                                  if (!uniqueProductIds.contains(producto.id)) {
                                    uniqueProductIds.add(producto.id);
                                    return true;
                                  }
                                  return false;
                                }).toList();

                                return Column(
                                  children: uniqueProducts.map((producto) {
                                    return Column(
                                      children: [
                                        ProductTile(
                                          imagen: producto.imagen,
                                          nombre: producto.nombre,
                                          marca: producto.marca,
                                          precio: producto.precio,
                                          requiereReceta:
                                              producto.requiereReceta,
                                          cartController: cartController,
                                        ),
                                        if (producto.requiereReceta)
                                          Column(
                                            children: [
                                              Button(
                                                title: 'Adjuntar receta',
                                                onPressed: () {
                                                  _showUploadDialog(context);
                                                },
                                                width: 200.0,
                                                height: 45,
                                                fontSize: 15,
                                              ),
                                              SizedBox(height: 10.0),
                                            ],
                                          ),
                                      ],
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
                                  'S/ ${(kitProductsController.subtotal).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
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
                      if (cartController.cartItems.isNotEmpty) {
                        Navigator.pushNamed(context, '/kit-delivery');
                      } else
                        Get.snackbar("Error", "No hay productos.");
                    },
                    width: 200.0,
                    backgroundColor: AppColors.primaryColor,
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
      endDrawer: CommonDrawer(),
      body: _buildBody(context),
      resizeToAvoidBottomInset: true,
    );
  }
}