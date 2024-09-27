import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mediplan/services/usuario_service.dart';
import '../../models/usuario.dart';

class LoginPageController extends GetxController{
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  RxString msg = ''.obs;
  RxBool hayError = false.obs;

  void goMainPage(BuildContext context) async {
    print("Estoy en el controlador");
    UsuarioService service = UsuarioService();
    Usuario? usuario = 
      await service.login(txtemail.text,txtpassword.text);
    if (txtemail.text == '' || txtpassword.text == '') {
      this.hayError.value = true;
      this.msg.value = 'Error: Debe de llenar usuario y contraseña';
      Future.delayed(Duration(seconds: 3), () {
        this.msg.value = '';
      });
    } else if (usuario != null) {
      this.hayError.value = false;
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushNamed(context, '/main-page', arguments: usuario.toJson());
      });
    } else {
      this.msg.value = 'ERROR: Usuario y contraseña no válidos';
      this.hayError.value = true;
      Future.delayed(Duration(seconds: 3), () {
        this.msg.value = '';
      });
    }
  }
}