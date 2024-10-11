import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/usuario.dart';

class UsuarioService {
  // Método privado para cargar y decodificar el archivo JSON
  Future<List<dynamic>> _loadUsuariosData() async {
    final String response =
        await rootBundle.loadString('assets/json/usuarios.json');
    final Map<String, dynamic> jsonData = jsonDecode(response);
    return jsonData['usuarios'] as List<dynamic>;
  }

  Future<Usuario?> login(String email, String password) async {
    final List<dynamic> data = await _loadUsuariosData();
    // Buscar el usuario con el email y password proporcionados
    final usuarioEncontrado = data.firstWhere(
      (map) =>
          (map as Map<String, dynamic>)['correo'] == email &&
          (map)['contraseña'] == password,
      orElse: () => null,
    );

    if (usuarioEncontrado != null) {
      print("usuario encontrado");
      return Usuario.fromMap(usuarioEncontrado as Map<String, dynamic>);
    } else {
      print("usuario no encontrado");
      return null;
    }
  }

  Future<Usuario?> fetchOne(int idUsuario) async {
    final List<dynamic> data = await _loadUsuariosData();
    // Buscar el usuario por idUsuario
    final usuarioEncontrado = data.firstWhere(
      (map) => (map as Map<String, dynamic>)['idUsuario'] == idUsuario,
      orElse: () => null,
    );

    if (usuarioEncontrado != null) {
      return Usuario.fromMap(usuarioEncontrado as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<bool> isEmailRegistered(String email) async {
    final List<dynamic> data = await _loadUsuariosData();
    
    // Buscar si el correo ya existe
    final usuarioEncontrado = data.firstWhere(
      (map) => (map as Map<String, dynamic>)['correo'] == email,
      orElse: () => null,
    );

    return usuarioEncontrado != null;
  }
}
