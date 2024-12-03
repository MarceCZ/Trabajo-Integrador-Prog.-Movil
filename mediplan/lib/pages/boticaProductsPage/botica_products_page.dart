import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/customSearchBar.dart';
import 'package:mediplan/components/custom_filter_button.dart';
import 'package:mediplan/components/custom_filter_dialog.dart';
import 'package:mediplan/components/floating_button.dart';
import 'package:mediplan/components/product_grid_view.dart';
import 'package:mediplan/models/producto_botica.dart';
import 'package:mediplan/pages/productDetailPage/product_detail_page.dart';
import '../../components/common_drawer.dart';
import 'botica_products_controller.dart';
import '../../components/commonAppBar/common_app_bar.dart';
import '../../configs/colors.dart';
import 'package:mediplan/components/cart_view.dart';

class BoticaProductsPage extends StatelessWidget {
  final BoticaProductsController control = Get.put(BoticaProductsController());

  BoticaProductsPage(
      {Key? key, required int boticaId, required String boticaNombre})
      : super(key: key) {
    print("Botica ID recibido: $boticaId, Nombre: $boticaNombre");
    control.cargarProductosDeBotica(boticaId, boticaNombre);
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.backgroundColor5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 17, top: 5),
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
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
                padding: EdgeInsets.only(left: 7),
                child: Text(
                  control.nombreBotica.value,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundColor3),
                )),
            SizedBox(height: 20),
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
            SizedBox(height: 16),
            Obx(() {
              print("Productos mostrados en la vista: ${control.productosFiltrados}");
              if (control.productosFiltrados.isEmpty) {
                return Center(child: Text('No hay productos disponibles'));
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
            Container(
              height: 50,
              color: AppColors.backgroundColor5,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
        endDrawer: CommonDrawer(),
      body: Obx(() {
        return _buildBody(context); // Retornar el widget _buildBody
      }),
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
        return Container(
          width: 350.0, // Establecer un ancho fijo para el BottomSheet
          child: CartView(), // Aquí se muestra el contenido de tu BottomSheet
        );
      },
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
