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
  var searchQuery = ''.obs;

  BoticaService boticaService = BoticaService();
  var boticas = <Botica>[].obs;

  var precioMin = 0.0.obs;
  var precioMax = 200.0.obs;
  var rangoPrecio = RangeValues(0, 200).obs; // Valor inicial del slider

  var productosFiltrados = <ProductoBotica>[].obs;
  var marcasSeleccionadas = <String>[].obs;
  var boticasFiltradas = <Botica>[].obs;

  HomeController() {
    listarProductos();
    listarBoticas();
  }

  void listarProductos() async {
    productos.value = await productoService.fetchAll();
    productosFiltrados.assignAll(productos);
    productos.refresh();
    actualizarMarcas();
    valoresFiltro();
  }

  void listarBoticas() async {
    boticas.value = await boticaService.fetchAll();
    boticasFiltradas.assignAll(boticas);
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

  void filtrarProductos() {
    // Filtra los productos según el rango de precios y las marcas seleccionadas
    productosFiltrados.value = productos.where((producto) {
      bool dentroDelRango = producto.precio >= rangoPrecio.value.start &&
          producto.precio <= rangoPrecio.value.end;

      bool marcaCoincide = marcasSeleccionadas.isEmpty ||
          marcasSeleccionadas.contains(producto.marca);

      bool coincideConBusqueda = searchQuery.value.isEmpty ||
          producto.nombre
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());

      return dentroDelRango && marcaCoincide && coincideConBusqueda;
    }).toList();
  }

  void filtrarBoticas(String query) {
    if (query.isEmpty) {
      boticasFiltradas.assignAll(boticas);
    } else {
      boticasFiltradas.assignAll(
        boticas
            .where((botica) =>
                botica.nombre.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }
}
