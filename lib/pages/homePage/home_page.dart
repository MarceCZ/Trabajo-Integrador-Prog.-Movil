import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/customSearchBar.dart';
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
                    backgroundColor: _selectedIndex == 0
                        ? AppColors
                            .primaryColor // Fondo verde si está seleccionado
                        : AppColors
                            .backgroundColor, // Fondo gris si no está seleccionado
                    textColor: _selectedIndex == 0
                        ? Colors.white // Texto blanco si está seleccionado
                        : Colors.black, // Texto negro si no está seleccionado
                    fontWeight: _selectedIndex == 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                    elevation: _selectedIndex == 0 ? 3 : 0,
                    width: 180.0,
                    height: 40.0,
                    fontSize: 15,
                  ),
                  Spacer(),
                  Button(
                    title: 'Boticas',
                    onPressed: () => _onItemTapped(1),
                    backgroundColor: _selectedIndex == 1
                        ? AppColors
                            .primaryColor // Fondo verde si está seleccionado
                        : AppColors
                            .backgroundColor, // Fondo gris si no está seleccionado
                    textColor: _selectedIndex == 1
                        ? Colors.white // Texto blanco si está seleccionado
                        : Colors.black, // Texto negro si no está seleccionado
                    fontWeight: _selectedIndex == 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                    elevation: _selectedIndex == 1 ? 3 : 0,
                    width: 180.0,
                    height: 40.0,
                    fontSize: 15,
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
                    child: CustomSearchBar(
                      placeholder: 'Buscar producto',
                      onChanged: (text) {
                        control.searchQuery.value = text;
                        control.filtrarProductos();
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.grisclarito, // Fondo gris claro
                      borderRadius:
                          BorderRadius.circular(30), // Bordes redondeados
                    ),
                    padding: EdgeInsets.only(left: 20, right: 15),
                    height: 40, // Altura del botón
                    child: InkWell(
                      onTap: () {
                        _showFilterDialog(context);
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Filtrar',
                            style: TextStyle(
                              color: Colors.black, // Texto negro
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Spacer(), // Espacio entre el texto y el ícono
                          Icon(
                            Icons.arrow_drop_down, // Ícono de flecha
                            color: Colors.black,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Obx(() {
                    if (control.productosFiltrados.isEmpty) {
                      return Center(
                          child: Text('No hay productos disponibles'));
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.63,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: control.productosFiltrados.length,
                        itemBuilder: (context, index) {
                          ProductoBotica producto =
                              control.productosFiltrados[index];
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
                  Container(height: 80, color: AppColors.backgroundColor5)
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
        height: MediaQuery.of(context).size.height,
        color: AppColors.backgroundColor5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  CustomSearchBar(
                    placeholder: 'Buscar botica',
                    onChanged: (text)=>{
                      control.filtrarBoticas(text)
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Obx(() {
                    if (control.boticasFiltradas.isEmpty) {
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
                        itemCount: control.boticasFiltradas.length,
                        itemBuilder: (context, index) {
                          Botica botica = control.boticasFiltradas[index];
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

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filtrar',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Divider(),
                Text(
                  'Precio',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Obx(
                  () => SliderTheme(
                      data: SliderThemeData(
                        showValueIndicator: ShowValueIndicator.always,
                        activeTrackColor: AppColors.primaryColor,
                        inactiveTrackColor: Colors.grey,
                        thumbColor: AppColors.primaryColor,
                      ),
                      child: RangeSlider(
                        values: control.rangoPrecio.value,
                        min: control.precioMin.value,
                        max: control.precioMax.value,
                        divisions:
                            (control.precioMax.value - control.precioMin.value)
                                .toInt(),
                        labels: RangeLabels(
                            'S/${control.rangoPrecio.value.start.round()}',
                            'S/${control.rangoPrecio.value.end.round()}'),
                        onChanged: (RangeValues values) {
                          control.rangoPrecio.value = values;
                          control.filtrarProductos();
                        },
                      )),
                ),
                SizedBox(height: 16),
                Text(
                  'Marca',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Obx(() {
                  // Usar Obx para observar la lista de marcas
                  return Wrap(
                    spacing: 10,
                    children: control.marcas.map((marca) {
                      return FilterChip(
                        label: Text(marca),
                        selected: control.marcasSeleccionadas.contains(marca),
                        onSelected: (bool selected) {
                          if (selected) {
                            control.marcasSeleccionadas.add(marca);
                          } else {
                            control.marcasSeleccionadas.remove(marca);
                          }
                          control.filtrarProductos();
                        },
                      );
                    }).toList(),
                  );
                }),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
