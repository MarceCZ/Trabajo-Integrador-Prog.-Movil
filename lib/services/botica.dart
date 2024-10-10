import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mediplan/models/botica.dart';

class BoticaService {
  Future<List<Botica>> fetchAll() async {
    List<Botica> boticas = [];
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    print(response);
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData['boticas'];
    boticas = data
        .map((map) => Botica.fromMap(map as Map<String, dynamic>))
        .toList();
    return boticas;
  }
}