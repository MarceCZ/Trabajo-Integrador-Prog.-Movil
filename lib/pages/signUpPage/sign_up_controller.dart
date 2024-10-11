import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/services/usuario_service.dart';

class SignUpController extends GetxController {
  // Controladores de los campos
  TextEditingController txtname = TextEditingController();
  TextEditingController txtlastname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController txtpassword = TextEditingController();

  // Variables observables para los mensajes de error
  var nameError = ''.obs;
  var lastNameError = ''.obs;
  var emailError = ''.obs;
  var phoneError = ''.obs;
  var dateError = ''.obs;
  var passwordError = ''.obs;

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
      validateDate();
    }
  }

  // Validaciones para los campos
  void validateName() {
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (txtname.text.isEmpty) {
      nameError.value = 'La casilla de nombre está vacía';
    } else if (!nameRegex.hasMatch(txtname.text)) {
      nameError.value = 'El nombre solo debe contener letras';
    } else {
      nameError.value = '';
    }
  }

  void validateLastName() {
    final lastNameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (txtlastname.text.isEmpty) {
      lastNameError.value = 'La casilla de apellidos está vacía';
    } else if (!lastNameRegex.hasMatch(txtlastname.text)) {
      lastNameError.value = 'Los apellidos solo deben contener letras';
    } else {
      lastNameError.value = '';
    }
  }

  Future<void> validateEmail() async {
    UsuarioService service = UsuarioService();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (txtemail.text.isEmpty) {
      emailError.value = 'La casilla del correo esta vacía';
    } else if (!emailRegex.hasMatch(txtemail.text)) {
      emailError.value = 'Ingrese un correo válido';
    } else {
      bool isRegistered = await service.isEmailRegistered(txtemail.text);
      if (isRegistered) {
        emailError.value = 'Este correo ya está registrado';
      } else {
        emailError.value = '';
      }
    }
  }

  void validatePhone() {
    final phoneRegex = RegExp(r'^[0-9]{9}$');
    if (phonenumber.text.isEmpty) {
      phoneError.value = 'La casilla de teléfono está vacía';
    } else if (!phoneRegex.hasMatch(phonenumber.text)) {
      phoneError.value = 'Debe ingresar exactamente 9 dígitos y que sean solo números';
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
      passwordError.value = 'La casilla de contraseña está vacía';
    } else {
      passwordError.value = '';
    }
  }

  // Validar campos del formulario
  bool validateForm() {
    validateName();
    validateLastName();
    validateEmail();
    validatePhone();
    validateDate();
    validatePassword();

    // Verdadero si todos los campos son válidos
    return nameError.value.isEmpty &&
        lastNameError.value.isEmpty &&
        emailError.value.isEmpty &&
        phoneError.value.isEmpty &&
        dateError.value.isEmpty &&
        passwordError.value.isEmpty;
  }
}
