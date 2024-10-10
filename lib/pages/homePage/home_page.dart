import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/models/producto_botica.dart';
import 'package:mediplan/models/botica.dart';
import 'home_controller.dart';
import '../../components/common_app_bar.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/productcard.dart';
import 'package:mediplan/components/boticacard.dart';
import '../../configs/colors.dart';
import 'package:mediplan/components/floating_button.dart';
import 'package:mediplan/pages/productDetailPage/product_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController control = Get.put(HomeController());
  int _selectedIndex = 0; // Índice para controlar la vista seleccionada

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: _buildBody(context),
      floatingActionButton: FloatingButton(
        onPressed: () {
          // Lógica cuando se presiona el botón flotante
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Método para construir el cuerpo de la página
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Botones para cambiar entre Productos y Boticas
          Container(
            color: AppColors.backgroundColor5, // Asigna el color de fondo
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    title: 'Productos',
                    onPressed: () => _onItemTapped(0),
                    width: 180.0,
                    height: 40.0,
                  ),
                  const SizedBox(width: 16.0),
                  Button(
                    title: 'Boticas',
                    onPressed: () => _onItemTapped(1),
                    width: 180.0,
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ),
          // Contenido que cambia según el botón seleccionado
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildProductView(context),
                _buildStoreView(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Vista para mostrar los productos
  Widget _buildProductView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.backgroundColor5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Button(
                    title: 'Filtrar',
                    onPressed: () {
                      // lógica de filtro
                    },
                    height: 40.0,
                  ),
                  const SizedBox(height: 16.0),
                  Obx(() {
                    if (control.productos.isEmpty) {
                      return Center(
                          child: Text('No hay productos disponibles'));
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: control.productos.length,
                        itemBuilder: (context, index) {
                          ProductoBotica producto = control.productos[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailPage(pId: producto.id)),
                                );
                              },
                              child: ProductCard(
                                imageUrl: producto.imagen,
                                title: '${producto.nombre} | ${producto.marca}',
                                description: producto.presentacion,
                                price: producto.precio,
                                onAddPressed: () {
                                  print('Producto añadido al carrito');
                                },
                                chipLabel: producto.botica,
                                chipTextColor: Colors.black,
                                chipBackgroundColor: Color(0xFFCCCCCC),
                                chipFontSize: 9,
                                onChipTap: () {
                                  print('Chip de Recomendado presionado');
                                },
                              ));
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Vista para mostrar las boticas
  Widget _buildStoreView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.backgroundColor5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Obx(() {
                    if (control.productos.isEmpty) {
                      return Center(child: Text('No hay boticas disponibles'));
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: control.boticas.length,
                        itemBuilder: (context, index) {
                          Botica botica = control.boticas[index];
                          return BoticaCard(
                            imageUrl: botica.logo,
                            title: botica.nombre,
                            productCount: botica.cantidadProductos,
                            onTap: () {
                              print('Ir a la botica');
                            },
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
