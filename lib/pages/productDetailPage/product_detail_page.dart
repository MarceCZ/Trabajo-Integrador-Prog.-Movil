import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/customchip.dart';
import 'package:mediplan/configs/colors.dart';
import '../../components/common_drawer.dart';
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
        return const Center(child: Text('Producto no encontrado'));
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
                  padding: const EdgeInsets.only(left: 10.0, bottom: 17, top: 5),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back, color: Colors.black),
                      const SizedBox(width: 5),
                      const Text(
                        'Volver',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 5, top: 5),
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
                      const SizedBox(height: 16),
                      Text(
                        '${producto.presentacion}',
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      // Nombre del producto
                      Text(
                        '${producto.nombre} | ${producto.marca}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          CustomChip(
                            label: producto.botica,
                            textColor: AppColors.secondaryColor,
                            backgroundColor: AppColors.backgroundColor,
                            fontSize: 12,
                          ),
                          const SizedBox(width: 5.0), // Espacio entre el chip y el ícono
                          if (producto.requiereReceta)
                            Row(
                              children: const [
                                Icon(
                                  Icons.assignment,
                                  color: Colors.red,
                                  size: 20.0,
                                ),
                                SizedBox(width: 4.0), 
                                Text(
                                  'Requiere receta',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'S/ ${producto.precio.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 61, 61),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Desplegables de descripción, contraindicaciones, advertencias
                      ExpansionTile(
                        title: const Text('Descripción'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(producto.descripcion ?? 'No disponible'),
                          )
                        ],
                      ),
                      ExpansionTile(
                        title: const Text('Contraindicaciones'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(producto.contraindicaciones ?? 'No disponible'),
                          )
                        ],
                      ),
                      ExpansionTile(
                        title: const Text('Advertencias y precauciones'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(producto.advertencias ?? 'No disponible'),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Selector de cantidad y botón de agregar
                    ],
                  ),
                ),
              ),
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
                        width: 2,
                      ),
                    ),
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: controller.decrementQuantity,
                          icon: const Icon(Icons.remove),
                          constraints: const BoxConstraints(), // Evita un tamaño fijo del botón
                          padding: EdgeInsets.zero, // Remueve el padding extra
                        ),
                        Obx(() => Text(
                          '${controller.quantity.value}',
                          style: const TextStyle(fontSize: 18),
                        )),
                        IconButton(
                          onPressed: controller.incrementQuantity,
                          icon: const Icon(Icons.add),
                          constraints: const BoxConstraints(), // Evita un tamaño fijo del botón
                          padding: EdgeInsets.zero, // Remueve el padding extra
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
                height: 50, 
                color: AppColors.backgroundColor5, 
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      endDrawer: CommonDrawer(),
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
