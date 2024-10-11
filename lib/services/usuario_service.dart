import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/usuario.dart';

class UsuarioService {
  Future<Usuario?> login(String email, String password) async {
    if (email == 'admin@example.com' && password == 'admin') {
      return Usuario(idUsuario: 1, correo: 'pepe@ulima.edu.pe');
    } else {
      return null;
    }
  }

  Future<List<Usuario>> fetchAll() async {
    List<Usuario> usuarios = [];
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    print(response);
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData['usuarios'];
    usuarios = data
        .map((map) => Usuario.fromMap(map as Map<String, dynamic>))
        .toList();
    return usuarios;
  }


  Future<Usuario?> fetchOne(int idUsuario) async {
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData['usuarios'];

    // Buscar el usuario por idUsuario
    final usuarioEncontrado = data.firstWhere(
      (map) => (map as Map<String, dynamic>)['idUsuario'] == idUsuario,
      orElse: () => null,
    );

    if (usuarioEncontrado != null) {
      return Usuario.fromMap(usuarioEncontrado as Map<String, dynamic>);
    } else {
      return null; // Si no se encuentra el usuario, devolvemos null
    }
  }
}