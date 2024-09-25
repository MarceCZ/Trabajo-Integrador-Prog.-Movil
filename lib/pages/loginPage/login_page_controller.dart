import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginPageController extends GetxController{
 TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  RxString msg = ''.obs;

  void goMainPage(BuildContext context) async {
    print("Estoy en el controlador");

    //UsuarioService service = UsuarioService();


  }
}