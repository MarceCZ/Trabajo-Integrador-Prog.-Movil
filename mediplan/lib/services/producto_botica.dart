import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:mediplan/models/producto_botica.dart';

class ProductoBoticaService {
  final String baseUrl = 'http://192.168.56.1:4567/';

  Future<List<ProductoBotica>> fetchAll() async {
    final response = await http.get(Uri.parse('$baseUrl/producto/listar'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((producto) => ProductoBotica.fromMap(producto)).toList();
    } else {
      throw Exception("Error al obtener los productos");
    }
  }

  Future<List<ProductoBotica>> fetchFiltered(
      {double minPrecio = 0,
      double maxPrecio = 1000,
      List<String> marcas = const [],
      String busqueda = ''}) async {
    final url = Uri.parse('$baseUrl/producto/listar_filtrado')
        .replace(queryParameters: {
      'min_precio': minPrecio.toString(),
      'max_precio': maxPrecio.toString(),
      'marcas': marcas.join(','),
      'busqueda': busqueda,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((producto) => ProductoBotica.fromMap(producto)).toList();
    } else {
      throw Exception("Error al filtrar los productos");
    }
  }

  Future<List<ProductoBotica>> fetchFilteredByBotica({
    required int boticaId,
    double minPrecio = 0,
    double maxPrecio = 1000,
    List<String> marcas = const [],
    String busqueda = '',
  }) async {
    final url = Uri.parse('$baseUrl/botica/$boticaId/productos_filtrados')
        .replace(queryParameters: {
      'min_precio': minPrecio.toString(),
      'max_precio': maxPrecio.toString(),
      'marcas': marcas.join(','),
      'busqueda': busqueda,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((producto) => ProductoBotica.fromMap(producto)).toList();
    } else if (response.statusCode == 404) {
      return []; // Si no hay productos, devuelve una lista vacía
    } else {
      throw Exception("Error al filtrar los productos de la botica");
    }
  }

}
