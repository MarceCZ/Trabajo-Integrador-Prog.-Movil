import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mediplan/models/kit_producto.dart';
import 'package:http/http.dart' as http;

class KitProductoService {
  final String baseUrl = 'http://192.168.1.40:4567/';

  Future<List<KitProducto>> fetchAll() async {
    List<KitProducto> kitProductos = [];
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    print(response);
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData['kit_productos'];
    kitProductos = data
        .map((map) => KitProducto.fromMap(map as Map<String, dynamic>))
        .toList();
    return kitProductos;
  }

  Future<KitProducto?> fetchOne(int id) async {
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData['kit_productos'];

    final kitProductoEncontrado = data.firstWhere(
      (map) => (map as Map<String, dynamic>)['id'] == id,
      orElse: () => null,
    );

    if (kitProductoEncontrado != null) {
      return KitProducto.fromMap(kitProductoEncontrado as Map<String, dynamic>);
    } else {
      return null; // Si no se encuentra el KitProducto, devolvemos null
    }
  }
/*
  Future<List<KitProducto>> fetchByKit(int idKit) async {
    List<KitProducto> kitProductos = [];
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData['kit_productos'];

    // Buscar los productos por idKit
    final productosEncontrados = data.where(
      (map) => (map as Map<String, dynamic>)['id_kit'] == idKit,//idKit
    );

    kitProductos = productosEncontrados
        .map((map) => KitProducto.fromMap(map as Map<String, dynamic>))
        .toList();

    return kitProductos;
  }*/

  /* Future<List<KitProducto>> fetchByKit(int idKit) async {
  List<KitProducto> kitProductos = [];
  final String response = await rootBundle.loadString('assets/json/data.json');
  final Map<String, dynamic> jsonData = jsonDecode(response);
  final List<dynamic> data = jsonData['kit_productos'];

  // Buscar los productos por idKit
  final productosEncontrados = data.where(
    (map) {
      final kitId = (map as Map<String, dynamic>)['id_kit'];
      return kitId != null && kitId == idKit; // Verificar que no sea nulo
    },
  );

  kitProductos = productosEncontrados
      .map((map) => KitProducto.fromMap(map as Map<String, dynamic>))
      .toList();

  return kitProductos;
}*/

  Future<List<KitProducto>> fetchByKit(int idUsuario) async {
    final response =
        await http.get(Uri.parse('$baseUrl/suscripcion/$idUsuario/productos'));
    print('busqueda productos de kit');
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data
          .map((producto) => KitProducto.fromMapService(producto))
          .toList();
    } else {
      throw Exception("Error al obtener los productos");
    }
  }
}
