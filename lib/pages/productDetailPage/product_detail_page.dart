import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_detail_controller.dart';

class ProductDetailPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;

  ProductDetailPage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  }) : super(key: key);

  // Crea una instancia del controlador para manejar la lógica
  final ProductDetailController controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
        title: const Text(
          'Detalle del Producto',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto
              Center(
                child: Image.network(
                  imageUrl,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              // Título del producto
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              // Precio
              Text(
                'S/ ${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16.0),
              // Descripción
              ExpansionTile(
                title: const Text(
                  'Descripción',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(description),
                  ),
                ],
              ),
              // Contraindicaciones
              ExpansionTile(
                title: const Text(
                  'Contraindicaciones',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Las contraindicaciones del producto deben ser indicadas aquí.',
                    ),
                  ),
                ],
              ),
              // Advertencias y precauciones
              ExpansionTile(
                title: const Text(
                  'Advertencias y precauciones',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Las advertencias y precauciones sobre el uso del producto deben ser indicadas aquí.',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Selector de cantidad y botón para agregar al carrito
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Selector de cantidad
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: controller.decrementQuantity,
                          icon: const Icon(Icons.remove),
                        ),
                        Obx(() => Text(controller.quantity.value.toString())),
                        IconButton(
                          onPressed: controller.incrementQuantity,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  // Botón para agregar al carrito
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 16.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      controller.addToCart();
                    },
                    child: const Text(
                      'Agregar al kit',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
