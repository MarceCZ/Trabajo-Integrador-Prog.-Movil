import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:mediplan/models/botica.dart';

class BoticaService {

  final String baseUrl = 'http://192.168.56.1:4567/';

  Future<List<Botica>> fetchAll() async {
    final response = await http.get(Uri.parse('$baseUrl/botica/listar'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((botica) => Botica.fromMap(botica)).toList();
    } else {
      throw Exception("Error al obtener las boticas");
    }
  }

    Future<List<Botica>> fetchFiltered(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/botica/listar_filtrado?busqueda=$query'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((botica) => Botica.fromMap(botica)).toList();
    } else {
      throw Exception("Error al filtrar las boticas");
    }
  }

}