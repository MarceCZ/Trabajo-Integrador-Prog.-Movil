import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/models/producto_botica.dart';
import 'home_controller.dart';
import '../../components/common_app_bar.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/productcard.dart';
import '../../configs/colors.dart';

class HomePage extends StatelessWidget {
  HomeController control = Get.put(HomeController());

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            color: AppColors.backgroundColor5,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                              title: 'Productos',
                              onPressed: () {
                                //logica
                              },
                              width: 180.0,
                              height: 40.0),
                          const SizedBox(width: 16.0),
                          Button(
                              title: 'Boticas',
                              onPressed: () {
                                //logica
                              },
                              width: 180.0,
                              height: 40.0),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40.0,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Buscar producto',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 8.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Button(
                            title: 'Filtrar',
                            onPressed: () {
                              //logica
                            },
                            height: 40.0),
                        Obx(() {
                          if (control.productos.isEmpty) {
                            return Center(
                                child: Text('No hay productos disponibles'));
                          } else {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Número de columnas
                                childAspectRatio:
                                    0.625, // Relación de aspecto para ajustar el tamaño de las tarjetas
                                crossAxisSpacing:
                                    10.0, // Espaciado horizontal entre las tarjetas
                                mainAxisSpacing:
                                    10.0, // Espaciado vertical entre las tarjetas
                              ),
                              itemCount: control.productos.length,
                              itemBuilder: (context, index) {
                                ProductoBotica producto =
                                    control.productos[index];
                                return ProductCard(
                                  imageUrl: producto.imagen,
                                  title:
                                      '${producto.nombre} | ${producto.marca}',
                                  description: producto.presentacion,
                                  price: producto.precio,
                                  onAddPressed: () {
                                    print('Producto añadido al carrito');
                                  },
                                  chipLabel: producto.botica,
                                  chipTextColor: Colors.black,
                                  chipBackgroundColor: Color(0xFFCCCCCC),
                                  onChipTap: () {
                                    print('Chip de Recomendado presionado');
                                  },
                                );
                              },
                            );
                          }
                        })
                      ],
                    ),
                  )
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: _buildBody(context),
    );
  }
}
