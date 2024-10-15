import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mediplan/models/kit.dart';

class KitService {
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
  }
}
