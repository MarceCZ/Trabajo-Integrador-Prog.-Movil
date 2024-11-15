import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mediplan/services/usuario_service.dart';
import '../../models/service_http_response.dart';

class ResetPasswordController extends GetxController {
  TextEditingController txtemail = TextEditingController();
  var emailError = ''.obs;
  var isEmailSent = false.obs;
  var isLoading = false.obs;  // Indicador de carga

  // Método para validar el email
  Future<void> validateEmail() async {
    UsuarioService service = UsuarioService();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    // Verificar que el email no esté vacío y sea válido
    if (txtemail.text.isEmpty) {
      emailError.value = 'La casilla del correo está vacía';
    } else if (!emailRegex.hasMatch(txtemail.text)) {
      emailError.value = 'Ingrese un correo válido';
    } else {
      isLoading.value = true;  // Mostrar indicador de carga
      try {
        // Verificar si el correo está registrado con un timeout de 10 segundos
        ServiceHttpResponse response = await service.recoverPassword(txtemail.text).timeout(Duration(seconds: 10));

        if (response.status == 200) {
          emailError.value = '';  
          isEmailSent.value = true;
        } else {
          emailError.value = response.body;  // Mostrar el error
          showSnackbar('Error', response.body);
        }
      } catch (e) {
        // Manejo del timeout o error de conexión
        emailError.value = 'No se pudo conectar con el servidor. Intente de nuevo más tarde.';
        showSnackbar('Error', 'No se pudo conectar con el servidor. Intente de nuevo más tarde.');
      } finally {
        isLoading.value = false;  // Ocultar indicador de carga
      }
    }
  }

  // Método para validar el formulario
  Future<bool> validate() async {
    await validateEmail();
    return emailError.value.isEmpty;
  }

  // Método para mostrar un Snackbar de error
  void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      '',
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Icon(Icons.warning_amber, color: const Color.fromARGB(255, 243, 136, 22), size: 35),
      ),
      backgroundColor: Colors.black.withOpacity(0.6),
      colorText: Colors.white,
      duration: Duration(seconds: 8),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
