import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mediplan/models/kit.dart';
import 'package:http/http.dart' as http;
import 'package:mediplan/models/service_http_response.dart';

class KitService {
  final String baseUrl = 'http://192.168.1.40:4567/';  // Cambia esta URL por la URL del servidor


  Future<List<Kit>> fetchAll() async {
    List<Kit> kits = [];
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    print(response);
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData['kits'];
    kits = data
        .map((map) => Kit.fromMap(map as Map<String, dynamic>))
        .toList();
    return kits;
  }


  Future<Kit?> fetchOne(int id) async {
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData['kits'];

    final kitEncontrado = data.firstWhere(
      (map) => (map as Map<String, dynamic>)['id'] == id,
      orElse: () => null,
    );

    if (kitEncontrado != null) {
      return Kit.fromMap(kitEncontrado as Map<String, dynamic>);
    } else {
      return null; // Si no se encuentra el Kit, devolvemos null
    }
  }
/*
  Future<Kit?> fetchOneUser(int idUsuario) async {
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData['kits'];

    final kitEncontrado = data.firstWhere(
      (map) => (map as Map<String, dynamic>)['idUsuario'] == idUsuario,
      orElse: () => null,
    );

    if (kitEncontrado != null) {
      return Kit.fromMap(kitEncontrado as Map<String, dynamic>);
    } else {
      return null; // Si no se encuentra el Kit, devolvemos null
    }
  }*/

  Future<Kit?> fetchOneUser(int idUsuario) async {
    final url = Uri.parse('${baseUrl}suscripcion/complete/$idUsuario');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Kit.fromMapService(data);
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error al recuperar el kit: $e');
      return null;
    }
  }

  Future<ServiceHttpResponse?> cancelarSuscripcion(int idSuscripcion) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('${baseUrl}suscripcion/cancelar/$idSuscripcion');
    try {
      final response = await http.put(
        url
      );

      serviceResponse.status = response.statusCode;
      serviceResponse.body = response.statusCode == 200 ? 'Kit cancelado correctamente' : response.body;
      print('Response: ${response.body}');
    } catch (e) {
      serviceResponse.status = 500;
      serviceResponse.body = 'Error en la conexión o en el servidor';
      print('Error: $e');
    }
    return serviceResponse;
  }
}
