import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mediplan/models/producto_botica.dart';

class ProductoBoticaService {
  Future<List<ProductoBotica>> fetchAll() async {
    List<ProductoBotica> productos = [];
<<<<<<< Updated upstream
    final String response= await rootBundle.loadString("assets/json/data.json");
    final List<dynamic> data= jsonDecode(response);
    productos= data.map((map)=> 
      ProductoBotica.fromMap(map as Map<String, dynamic>)).toList();
=======
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    print(response);
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData['productos'];
    productos = data
        .map((map) => ProductoBotica.fromMap(map as Map<String, dynamic>))
        .toList();
>>>>>>> Stashed changes
    return productos;
  }
}
