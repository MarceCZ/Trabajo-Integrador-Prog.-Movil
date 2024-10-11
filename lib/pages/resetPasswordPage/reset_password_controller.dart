import 'package:get/get.dart'; 
import 'package:flutter/material.dart';  
import 'package:mediplan/services/usuario_service.dart';

class ResetPasswordController extends GetxController {
  TextEditingController txtemail = TextEditingController();
  var emailError = ''.obs;

  Future<void> validateEmail() async {
    UsuarioService service = UsuarioService();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    if (txtemail.text.isEmpty) {
      emailError.value = 'La casilla del correo está vacía';
    } else if (!emailRegex.hasMatch(txtemail.text)) {
      emailError.value = 'Ingrese un correo válido';
    } else {
      bool isRegistered = await service.isEmailRegistered(txtemail.text);
      if (!isRegistered) {
        emailError.value = 'Este correo no está registrado';
      } else {
        emailError.value = ''; 
      }
    }
  }

  Future<bool> validate() async {
    await validateEmail();  
    return emailError.value.isEmpty;
  }
}
