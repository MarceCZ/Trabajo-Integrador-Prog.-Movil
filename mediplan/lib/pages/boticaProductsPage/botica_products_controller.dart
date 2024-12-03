import 'package:get/get.dart';
import 'package:mediplan/models/producto_botica.dart';
import 'package:mediplan/services/producto_botica.dart';
import 'package:flutter/material.dart';

class BoticaProductsController extends GetxController {
  var productos = <ProductoBotica>[].obs;
  var productosFiltrados = <ProductoBotica>[].obs;
  var nombreBotica = ''.obs;

  var marcas = <String>[].obs;
  var marcasSeleccionadas = <String>[].obs;
  var searchQuery = ''.obs;

  var precioMin = 0.0.obs;
  var precioMax = 200.0.obs;
  var rangoPrecio = RangeValues(0, 200).obs;

  Future<void> cargarProductosDeBotica(int boticaId, String boticaNombre) async {
    ProductoBoticaService service = ProductoBoticaService();

    try {
      List<ProductoBotica> todosLosProductos = await service.fetchFilteredByBotica(boticaId: boticaId);
      print("Productos cargados desde la botica ${boticaNombre}: ${todosLosProductos.length}");

      productos.value = todosLosProductos;
      productosFiltrados.value = todosLosProductos.toList();
      nombreBotica.value = boticaNombre;

      actualizarMarcas();
      valoresFiltro();
    } catch (e) {
      print("Error al cargar productos de la botica $boticaNombre: $e");
    }
  }

  void actualizarMarcas() {
    var marcasUnicas = productos.map((producto) => producto.marca).toSet().toList();
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
}
