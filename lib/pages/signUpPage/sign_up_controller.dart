import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    if (txtname.text.isEmpty) {
      nameError.value = 'La casilla de nombre está vacía';
    } else {
      nameError.value = '';
    }
  }

  void validateLastName() {
    if (txtlastname.text.isEmpty) {
      lastNameError.value = 'La casilla de apellidos está vacía';
    } else {
      lastNameError.value = '';
    }
  }

  void validateEmail() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (txtemail.text.isEmpty || !emailRegex.hasMatch(txtemail.text)) {
      emailError.value = 'Ingrese un correo válido';
    } else {
      emailError.value = '';
    }
  }

  void validatePhone() {
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (phonenumber.text.isEmpty || !phoneRegex.hasMatch(phonenumber.text)) {
      phoneError.value = 'Ingrese un número de teléfono válido';
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
