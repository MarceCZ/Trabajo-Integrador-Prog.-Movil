import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/models/usuario.dart';
import 'package:mediplan/services/usuario_service.dart';
import 'package:mediplan/models/service_http_response.dart';
import '../../components/commonAppBar/common_app_bar_controller.dart';

class ProfileController extends GetxController {
  CommonAppBarController appBarControl = Get.put(CommonAppBarController());

  UsuarioService usuarioService = UsuarioService();

  // Controladores de los campos
  TextEditingController txtname = TextEditingController();
  TextEditingController txtlastname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController alergy = TextEditingController();
  TextEditingController others = TextEditingController();
  var name = ''.obs;
  var lastname = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var phone = ''.obs;
  var fecha = ''.obs;
  var altura = ''.obs;
  var peso = ''.obs;
  var condicion = ''.obs;
  var alergia = ''.obs;
  var otros = ''.obs;

  // Variables observables para los mensajes de error
  var nameError = ''.obs;
  var lastNameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var phoneError = ''.obs;
  var dateError = ''.obs;
  var heightError = ''.obs;
  var weightError = ''.obs;
  var conditionError = ''.obs;
  var alergyError = ''.obs;
  var othersError = ''.obs;

  var errorMessage = ''.obs;

  var isLoading = false.obs;
  void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      '',
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Icon(Icons.warning_amber,
            color: const Color.fromARGB(255, 243, 136, 22), size: 35),
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

  void cerrarSesion() {
    Usuario usuarioNull = Usuario(idUsuario: 0, correo: '', contrasena: '');
    appBarControl.updateUsuario(usuarioNull); //eliminar updateUsuario
    appBarControl.updateIdUsuario(0);
  }

  void actualizarUsuario() async {
    Usuario usuario = Usuario(
      idUsuario: appBarControl.idUsuario.value,
      contrasena: txtpassword.text,
      nombres: txtname.text,
      apellidos: txtlastname.text,
      correo: txtemail.text,
      celular: phonenumber.text,
      fechaNacimiento: DateFormat('dd/MM/yyyy').parse(date.text),
      altura: height.text.isEmpty? null : double.parse(height.text),
      peso: weight.text.isEmpty? null : double.parse(weight.text),
      condicionesMedicas: condition.text,
      alergias: alergy.text,
      otros: others.text,
    );
    isLoading.value = true; // Mostrar indicador de carga
    print('Usuario actualizado: $usuario');
    //appBarControl.updateUsuario(usuario);
    try {
      ServiceHttpResponse? response =
          await usuarioService.update(usuario).timeout(Duration(seconds: 10));

      isLoading.value = false;
      if (response != null && response.status == 200) {
        buscarUsuario();
      } else {
        errorMessage.value =
            response?.body ?? 'No se pudo guardar la información.';
        showSnackbar('Error', errorMessage.value);
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value =
          'No se pudo conectar con el servidor. Verifica tu conexión.';
      showSnackbar('Error', errorMessage.value);
    }

    print('Usuario actualizado: $usuario');
    Future.delayed(Duration(seconds: 1), () {
      buscarUsuario();
    });
  }
/*
  void buscarUsuario() async {
    final usuarioBar = appBarControl.usuario.value;
    print('Usuario bar: $usuarioBar');
    if (appBarControl.usuario.value.alergias == null ||
        appBarControl.usuario.value.altura == null ||
        appBarControl.usuario.value.apellidos == null ||
        appBarControl.usuario.value.celular == null ||
        appBarControl.usuario.value.condicionesMedicas == null ||
        appBarControl.usuario.value.fechaNacimiento == null ||
        appBarControl.usuario.value.nombres == null ||
        appBarControl.usuario.value.peso == null ) {
      final usuario =
          await usuarioService.fetchOne(appBarControl.usuario.value.idUsuario);
      if (usuario != null) {
        print('Usuario encontrado: $usuario');

        txtname.text = usuario.nombres ?? '';
        txtlastname.text = usuario.apellidos ?? '';
        txtemail.text = usuario.correo;
        phonenumber.text = usuario.celular ?? '';
        date.text = DateFormat('dd/MM/yyyy')
            .format(usuario.fechaNacimiento ?? DateTime.now());
        height.text = usuario.altura.toString();
        weight.text = usuario.peso.toString();
        condition.text = usuario.condicionesMedicas ?? '';
        alergy.text = usuario.alergias ?? '';
        others.text = usuario.otros ?? '';
        name.value = usuario.nombres ?? '';
        lastname.value = usuario.apellidos ?? '';
        email.value = usuario.correo;
        phone.value = usuario.celular ?? '';
        fecha.value = DateFormat('dd/MM/yyyy')
            .format(usuario.fechaNacimiento ?? DateTime.now());
        altura.value = usuario.altura.toString();
        peso.value = usuario.peso.toString();
        condicion.value = usuario.condicionesMedicas ?? '';
        alergia.value = usuario.alergias ?? '';
        otros.value = usuario.otros ?? '';
      }
    } else {
      txtname.text = appBarControl.usuario.value.nombres ?? '';
      txtlastname.text = appBarControl.usuario.value.apellidos ?? '';
      txtemail.text = appBarControl.usuario.value.correo;
      phonenumber.text = appBarControl.usuario.value.celular ?? '';
      date.text = DateFormat('dd/MM/yyyy')
          .format(appBarControl.usuario.value.fechaNacimiento ?? DateTime.now());
      height.text = appBarControl.usuario.value.altura.toString();
      weight.text = appBarControl.usuario.value.peso.toString();
      condition.text = appBarControl.usuario.value.condicionesMedicas ?? '';
      alergy.text = appBarControl.usuario.value.alergias ?? '';
      others.text = appBarControl.usuario.value.otros ?? '';
      name.value = appBarControl.usuario.value.nombres ?? '';
      lastname.value = appBarControl.usuario.value.apellidos ?? '';
      email.value = appBarControl.usuario.value.correo;
      phone.value = appBarControl.usuario.value.celular ?? '';
      fecha.value = DateFormat('dd/MM/yyyy')
          .format(appBarControl.usuario.value.fechaNacimiento ?? DateTime.now());
      altura.value = appBarControl.usuario.value.altura.toString();
      peso.value = appBarControl.usuario.value.peso.toString();
      condicion.value = appBarControl.usuario.value.condicionesMedicas ?? '';
      alergia.value = appBarControl.usuario.value.alergias ?? '';
      otros.value = appBarControl.usuario.value.otros ?? '';
    }
  }*/

  void buscarUsuario() async {
    final idUsuarioBar = appBarControl.idUsuario.value;
    final usuarioBar = appBarControl.usuario.value;
    print('Usuario bar: $idUsuarioBar');
    if (idUsuarioBar != 0) {
      final usuario = await usuarioService.fetchOne(idUsuarioBar);
      if (usuario != null) {
        print('Usuario encontrado: $usuario');

        txtname.text = usuario.nombres ?? '';
        txtlastname.text = usuario.apellidos ?? '';
        txtemail.text = usuario.correo;
        txtpassword.text = '';
        phonenumber.text = usuario.celular ?? '';
        date.text = DateFormat('dd/MM/yyyy')
            .format(usuario.fechaNacimiento ?? DateTime.now());
        height.text = usuario.altura != null ? usuario.altura.toString() : '';
        weight.text = usuario.peso != null ? usuario.peso.toString() : '';
        condition.text = usuario.condicionesMedicas ?? '';
        alergy.text = usuario.alergias ?? '';
        others.text = usuario.otros ?? '';
        name.value = usuario.nombres ?? '';
        lastname.value = usuario.apellidos ?? '';
        email.value = usuario.correo;
        password.value = usuario.contrasena;
        phone.value = usuario.celular ?? '';
        fecha.value = DateFormat('dd/MM/yyyy')
            .format(usuario.fechaNacimiento ?? DateTime.now());
        altura.value = usuario.altura != null ? usuario.altura.toString() : '';
        peso.value = usuario.peso != null ? usuario.peso.toString() : '';
        condicion.value = usuario.condicionesMedicas ?? '';
        alergia.value = usuario.alergias ?? '';
        otros.value = usuario.otros ?? '';
      }
    }
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

  void validatePassword() {
    if (txtpassword.text.isEmpty) {
      passwordError.value = 'La contraseña es requerida';
    } else {
      passwordError.value = '';
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

  void validateHeight() {
    final heightRegex = RegExp(r'^[0-9]\.[0-9]{1,2}$');
    if (height.text.isEmpty || !heightRegex.hasMatch(height.text)) {
      heightError.value = 'Ingrese una altura válida';
    } else {
      heightError.value = '';
    }
  }

  void validateWeight() {
    final weightRegex = RegExp(r'^[0-9]{2,3}\.[0-9]{1,2}$');
    if (weight.text.isEmpty || !weightRegex.hasMatch(weight.text)) {
      weightError.value = 'Ingrese un peso válido';
    } else {
      weightError.value = '';
    }
  }

  void validateCondition() {
    if (condition.text.isEmpty) {
      conditionError.value = 'Ingrese una condición médica';
    } else {
      conditionError.value = '';
    }
  }

  void validateAlergy() {
    if (alergy.text.isEmpty) {
      alergyError.value = 'Ingrese una alergia';
    } else {
      alergyError.value = '';
    }
  }

  // Validar campos del formulario
  bool validateForm() {
    validateName();
    validateLastName();
    validateEmail();
    validatePassword();
    validatePhone();
    validateDate();
    /*validateHeight();
    validateWeight();
    validateCondition();
    validateAlergy();*/

    // Verdadero si todos los campos son válidos
    return nameError.value.isEmpty &&
            lastNameError.value.isEmpty &&
            emailError.value.isEmpty &&
            phoneError.value.isEmpty &&
            dateError.value
                .isEmpty /*&&
        heightError.value.isEmpty &&
        weightError.value.isEmpty &&
        conditionError.value.isEmpty &&
        alergyError.value.isEmpty*/
        ;
  }
}
