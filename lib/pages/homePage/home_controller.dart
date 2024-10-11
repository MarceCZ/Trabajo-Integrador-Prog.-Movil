import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/models/producto_botica.dart';
import 'package:mediplan/models/botica.dart';
import 'package:mediplan/services/botica.dart';
import 'package:mediplan/services/producto_botica.dart';

class HomeController extends GetxController {
  ProductoBoticaService productoService = ProductoBoticaService();
  var productos = <ProductoBotica>[].obs;
  var marcas = <String>[].obs;

  BoticaService boticaService = BoticaService();
  var boticas = <Botica>[].obs;

  var precioMin = 0.0.obs;
  var precioMax = 200.0.obs;
  var rangoPrecio = RangeValues(0, 200).obs; // Valor inicial del slider

  HomeController() {
    listarProductos();
    listarBoticas();
  }

  void listarProductos() async {
    productos.value = await productoService.fetchAll();
    productos.refresh();
    actualizarMarcas();
    valoresFiltro();
  }

  void listarBoticas() async {
    boticas.value = await boticaService.fetchAll();
    boticas.refresh();
  }

  void actualizarMarcas() {
    var marcasUnicas =
        productos.map((producto) => producto.marca).toSet().toList();
    marcas.assignAll(marcasUnicas);
  }

  void valoresFiltro() {
    if (productos.isNotEmpty) {
      precioMin.value = productos
          .map((producto) => producto.precio)
          .reduce((a, b) => a < b ? a : b);
      precioMax.value = productos
          .map((producto) => producto.precio)
          .reduce((a, b) => a > b ? a : b);
      rangoPrecio.value = RangeValues(precioMin.value, precioMax.value);
    }
  }
}
