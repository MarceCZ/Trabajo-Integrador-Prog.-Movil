import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/cart_controller.dart';
import 'package:mediplan/components/cart_view.dart';
import 'package:mediplan/components/custom_filter_button.dart';
import 'package:mediplan/components/customSearchBar.dart';
import 'package:mediplan/models/producto_botica.dart';
import 'package:mediplan/models/botica.dart';
import 'package:mediplan/pages/boticaProductsPage/botica_products_page.dart';
import '../../components/common_drawer.dart';
import 'home_controller.dart';
import '../../components/common_app_bar.dart';
import '../../configs/colors.dart';
import 'package:mediplan/components/floating_button.dart';
import 'package:mediplan/pages/productDetailPage/product_detail_page.dart';
import 'package:mediplan/components/custom_filter_dialog.dart';
import 'package:mediplan/components/custom_toggle_button.dart';
import 'package:mediplan/components/product_grid_view.dart';
import 'package:mediplan/components/botica_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController control = Get.put(HomeController());
  int _selectedIndex = 0; // Índice para controlar la vista seleccionada
  void initState() {
    super.initState();
    // Registrar el CartController en esta página
    Get.lazyPut(() => CartController());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      endDrawer: CommonDrawer(),
      body: _buildBody(context),
      floatingActionButton: FloatingButton(
        onPressed: () {
          _showCartBottomSheet(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

   void _showCartBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return   // Centrar el contenido en el BottomSheet
        Container(
          width: 350.0,  // Establecer un ancho fijo para el BottomSheet
          child: CartView(),  // Aquí se muestra el contenido de tu BottomSheet
        );
  
    },
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
                  CustomToggleButton(
                    title: 'Productos',
                    selectedIndex: _selectedIndex,
                    buttonIndex: 0,
                    onPressed: () => _onItemTapped(0),
                  ),
                  Spacer(),
                  CustomToggleButton(
                    title: 'Boticas',
                    selectedIndex: _selectedIndex,
                    buttonIndex: 1,
                    onPressed: () => _onItemTapped(1),
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
    return SafeArea(
        child: Container(
            color: AppColors.backgroundColor5,
            child: SingleChildScrollView(
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
                        CustomFilterButton(
                          title: 'Filtrar',
                          onTap: () {
                            _showFilterDialog(context);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        Obx(() {
                          if (control.productosFiltrados.isEmpty) {
                            return Center(
                                child: Text('No hay productos disponibles'));
                          } else {
                            return ProductGridView(
                              productos: control.productosFiltrados,
                              onProductTap: (ProductoBotica producto) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailPage(pId: producto.id),
                                  ),
                                );
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
            )));
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
                    onChanged: (text) => {control.filtrarBoticas(text)},
                  ),
                  const SizedBox(height: 16.0),
                  Obx(() {
                    if (control.boticasFiltradas.isEmpty) {
                      return Center(child: Text('No hay boticas disponibles'));
                    } else {
                      return BoticaGridView(
                        boticas: control.boticasFiltradas,
                        onBoticaTap: (Botica botica) {
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoticaProductsPage(
                              boticaId: botica.id,
                              boticaNombre: botica.nombre,
                            ),
                          ),
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
        return CustomFilterDialog(
          rangoPrecioInicial: control.rangoPrecio.value,
          precioMin: control.precioMin.value,
          precioMax: control.precioMax.value,
          marcas: control.marcas,
          marcasSeleccionadas: control.marcasSeleccionadas,
          onPrecioChanged: (RangeValues values) {
            control.rangoPrecio.value = values;
            control.filtrarProductos();
          },
          onMarcaChanged: (String marca) {
            if (control.marcasSeleccionadas.contains(marca)) {
              control.marcasSeleccionadas.remove(marca);
            } else {
              control.marcasSeleccionadas.add(marca);
            }
            control.filtrarProductos();
          },
        );
      },
    );
  }
}
