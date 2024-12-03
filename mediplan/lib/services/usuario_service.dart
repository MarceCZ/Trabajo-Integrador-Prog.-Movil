import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/usuario_login.dart';
import '../models/usuario_signUp.dart';
import 'package:http/http.dart' as http;
import '../models/service_http_response.dart';
import '../models/usuario.dart';

class UsuarioService {
  final String baseUrl = 'http://10.64.53.121:4567/';  // Cambia esta URL por la URL del servidor

  // Método para realizar el login
  Future<ServiceHttpResponse?> login(UsuarioLogin usuario) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('${baseUrl}usuario/login');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(usuario.toJson()),  
      );

      serviceResponse.status = response.statusCode;

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        serviceResponse.body = jsonResponse;
      } 
      else {
        serviceResponse.body = response.body;
      }
    } catch (e) {
      serviceResponse.status = 500;
      serviceResponse.body = 'Error en la conexión o en el servidor';
    }
    return serviceResponse;
  }

  // Método para registrar al usuario
  Future<ServiceHttpResponse?> registerUser(UsuarioSignUp usuario) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('${baseUrl}usuario/registro');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(usuario.toJson()),
      );

      serviceResponse.status = response.statusCode;
      serviceResponse.body = response.statusCode == 200 ? 'Usuario creado exitosamente' : response.body;
    } catch (e) {
      serviceResponse.status = 500;
      serviceResponse.body = 'Error en la conexión o en el servidor';
    }
    return serviceResponse;
  }


  // Método para recuperar la contraseña
  Future<ServiceHttpResponse> recoverPassword(String correo) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('${baseUrl}usuario/validar');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'correo': correo}),
      );

      serviceResponse.status = response.statusCode;

      if (response.statusCode == 200) {
        serviceResponse.body = 'Correo enviado con nueva contraseña';
      } else if (response.statusCode == 404) {
        serviceResponse.body = 'Correo no encontrado';
      } else {
        serviceResponse.body = 'Error al enviar el correo';
      }

    } catch (e) {
      serviceResponse.status = 500;
      serviceResponse.body = 'Error al conectar con el servidor';
    }

    return serviceResponse;
  }

  // Método para verificar si el correo ya está registrado
  Future<bool> isEmailRegistered(String correo) async {
    final url = Uri.parse('${baseUrl}usuario/verificar_correo');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'correo': correo}),
      );
      return response.statusCode == 409;
    } catch (e) {
      print('Error al verificar el correo: $e');
      return false;
    }
  }

  // Método para recuperar el usuario por ID
  Future<Usuario?> fetchOne(int idUsuario) async {
    final url = Uri.parse('${baseUrl}usuario/$idUsuario');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Usuario.fromMap(data);
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error al recuperar el usuario: $e');
      return null;
    }
  }

  Future<ServiceHttpResponse?> update(Usuario usuario) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('${baseUrl}usuario/${usuario.idUsuario}');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(usuario.toJson()),
      );

      serviceResponse.status = response.statusCode;
      serviceResponse.body = response.statusCode == 200 ? 'Usuario actualizado exitosamente' : response.body;
      print('Response: ${response.body}');
    } catch (e) {
      serviceResponse.status = 500;
      serviceResponse.body = 'Error en la conexión o en el servidor';
      print('Error: $e');
    }
    return serviceResponse;
  }
}
