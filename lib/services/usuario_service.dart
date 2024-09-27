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
}

