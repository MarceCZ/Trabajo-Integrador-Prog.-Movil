import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    color: Colors.white,
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen del producto
                        Center(
                          child: Image.network(
                            producto.imagen ?? '',
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '${producto.presentacion}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        // Nombre del producto
                        Text(
                          producto.nombre,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        // Presentación y precio

                        Text(
                          'S/ ${producto.precio.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        SizedBox(height: 16),
                        // Desplegables de descripción, contraindicaciones, advertencias
                        ExpansionTile(
                          title: Text('Descripción'),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text(producto.descripcion ?? 'No disponible'),
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
                        SizedBox(height: 16),
                        // Selector de cantidad y botón de agregar
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: controller.decrementQuantity,
                            icon: Icon(Icons.remove),
                          ),
                          Obx(() => Text(
                                '${controller.quantity.value}',
                                style: TextStyle(fontSize: 18),
                              )),
                          IconButton(
                            onPressed: controller.incrementQuantity,
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: controller.addToCart,
                        child: Text('Agregar al kit'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
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
