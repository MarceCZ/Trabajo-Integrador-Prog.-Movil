import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mediplan/services/usuario_service.dart';
import '../../models/usuario.dart';
import '../../components/common_app_bar_controller.dart';

class LoginPageController extends GetxController{
  CommonAppBarController appBarControl = Get.put(CommonAppBarController());

  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  RxString msg = ''.obs;
  RxBool hayError = false.obs;

  void goMainPage(BuildContext context) async {
    UsuarioService service = UsuarioService();
    Usuario? usuario = 
      await service.login(txtemail.text,txtpassword.text);
    if (txtemail.text == '' || txtpassword.text == '') {
      this.hayError.value = true;
      this.msg.value = 'Error: Debe de llenar usuario y contraseña';
      Future.delayed(Duration(seconds: 2), () {
        this.msg.value = '';
      });
    } else if (usuario != null) {
      this.hayError.value = false;
      appBarControl.updateUsuario(usuario);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushNamed(context, '/home', arguments: usuario.toJson());
      });
    } else {
      this.msg.value = 'ERROR: Usuario y contraseña no válidos';
      this.hayError.value = true;
      Future.delayed(Duration(seconds: 2), () {
        this.msg.value = '';
      });
    }
  }
}