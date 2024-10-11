import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/customchip.dart';
import 'package:mediplan/configs/colors.dart';
import 'product_detail_controller.dart';
import '../../components/common_app_bar.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductDetailController controller = Get.put(ProductDetailController());
  final int pId;

  ProductDetailPage({Key? key, required this.pId}) {}

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      final producto = controller.productDetail.value;

      if (producto == null) {
        return Center(child: Text('Producto no encontrado'));
      }

      return SingleChildScrollView(
          child: Container(
              color: AppColors.backgroundColor5,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, bottom: 17, top: 5),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              'Volver',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      color: Colors.white,
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 5, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Imagen del producto
                            Center(
                              child: Image.network(
                                producto.imagen ?? '',
                                height: 250,
                                width: 280,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '${producto.presentacion}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            // Nombre del producto
                            Text(
                              '${producto.nombre} | ${producto.marca}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryColor),
                            ),
                            CustomChip(
                                label: producto.botica,
                                textColor: AppColors.secondaryColor,
                                backgroundColor: AppColors.backgroundColor,
                                fontSize: 12),
                            // Presentación y precio
                            Text(
                              'S/ ${producto.precio.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 63, 61, 61)),
                            ),
                            SizedBox(height: 16),
                            // Desplegables de descripción, contraindicaciones, advertencias
                            ExpansionTile(
                              title: Text('Descripción'),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      producto.descripcion ?? 'No disponible'),
                                )
                              ],
                            ),
                            ExpansionTile(
                              title: Text('Contraindicaciones'),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(producto.contraindicaciones ??
                                      'No disponible'),
                                )
                              ],
                            ),
                            ExpansionTile(
                              title: Text('Advertencias y precauciones'),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      producto.advertencias ?? 'No disponible'),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            // Selector de cantidad y botón de agregar
                          ],
                        ),
                      )),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 2)
                        ),
                        height: 60,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: controller.decrementQuantity,
                              icon: Icon(Icons.remove),
                              constraints:
                                  BoxConstraints(), // Para evitar un tamaño fijo del botón
                              padding:
                                  EdgeInsets.zero, // Remueve el padding extra
                            ),
                            Obx(() => Text(
                                  '${controller.quantity.value}',
                                  style: TextStyle(fontSize: 18),
                                )),
                            IconButton(
                              onPressed: controller.incrementQuantity,
                              icon: Icon(Icons.add),
                              constraints:
                                  BoxConstraints(), // Para evitar un tamaño fijo del botón
                              padding:
                                  EdgeInsets.zero, // Remueve el padding extra
                            ),
                          ],
                        ),
                      ),
                      Button(
                        onPressed: () {
                          print('Agregar al kit');
                        },
                        title: 'Agregar al kit',
                        height: 60,
                        width: 220,
                        backgroundColor: AppColors.primaryColor,
                      )
                    ],
                  ),
                  Container(
                    height:
                        50, 
                    color: AppColors
                        .backgroundColor5, 
                  ),
                ],
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: FutureBuilder(
        future: controller.cargarProductDetail(pId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return _buildBody(context);
        },
      ),
    );
  }
}
