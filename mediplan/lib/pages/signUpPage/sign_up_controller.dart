import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/services/usuario_service.dart';
import '../../models/usuario_signUp.dart';

class SignUpController extends GetxController {
  // Controladores de los campos
  TextEditingController txtname = TextEditingController();
  TextEditingController txtlastname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController txtpassword = TextEditingController();

  // Variables observables para los mensajes de error y el estado de carga
  var nameError = ''.obs;
  var lastNameError = ''.obs;
  var emailError = ''.obs;
  var phoneError = ''.obs;
  var dateError = ''.obs;
  var passwordError = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Método para mostrar un Snackbar en caso de error
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

  // Método para seleccionar la fecha de nacimiento
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      date.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  // Validaciones para los campos
  void validateName() {
    if (txtname.text.isEmpty) {
      nameError.value = 'El nombre es requerido';
    } else {
      nameError.value = '';
    }
  }

  void validateLastName() {
    if (txtlastname.text.isEmpty) {
      lastNameError.value = 'Los apellidos son requeridos';
    } else {
      lastNameError.value = '';
    }
  }

  void validateEmail() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+'); 
    if (txtemail.text.isEmpty) {
      emailError.value = 'El correo es requerido';
    } else if (!emailRegex.hasMatch(txtemail.text)) {
      emailError.value = 'Ingrese un correo válido';
    } else {
      emailError.value = '';
    }
  }

  void validatePhone() {
    if (phonenumber.text.isEmpty) {
      phoneError.value = 'El teléfono es requerido';
    } else {
      phoneError.value = '';
    }
  }

  void validateDate() {
    if (date.text.isEmpty) {
      dateError.value = 'Seleccione una fecha de nacimiento';
    } else {
      dateError.value = '';
    }
  }

  void validatePassword() {
    if (txtpassword.text.isEmpty) {
      passwordError.value = 'La contraseña es requerida';
    } else {
      passwordError.value = '';
    }
  }

  // Método para registrar al usuario
  Future<void> registerUser(BuildContext context) async {
    validateName();
    validateLastName();
    validateEmail();
    validatePhone();
    validateDate();
    validatePassword();

    if (nameError.isNotEmpty ||
        lastNameError.isNotEmpty ||
        emailError.isNotEmpty ||
        phoneError.isNotEmpty ||
        dateError.isNotEmpty ||
        passwordError.isNotEmpty) {
      return;
    }

    UsuarioService service = UsuarioService();
    UsuarioSignUp usuario = UsuarioSignUp(
      nombres: txtname.text,
      apellidos: txtlastname.text,
      correo: txtemail.text,
      celular: phonenumber.text,
      fechaNacimiento: date.text,
      contrasena: txtpassword.text,
    );

    isLoading.value = true;

    try {
      bool emailExists = await service.isEmailRegistered(txtemail.text).timeout(Duration(seconds: 10));

      if (emailExists) {
        isLoading.value = false;
        emailError.value = 'El correo ya está registrado';
        showSnackbar('Advertencia', emailError.value);
        return;
      }

      // Si el correo no está registrado, proceder al siguiente paso
      isLoading.value = false;
      Get.toNamed('/profile-setting', arguments: {
        'nombres': usuario.nombres,
        'apellidos': usuario.apellidos,
        'correo': usuario.correo,
        'celular': usuario.celular,
        'fechaNacimiento': usuario.fechaNacimiento,
        'contrasena': usuario.contrasena,
      });
    } catch (e) {
      isLoading.value = false;
      showSnackbar(
        'Error',
        'No se pudo conectar con el servidor. Verifica tu conexión a internet.',
      );
    }
  }
}
