import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mediplan/services/usuario_service.dart';
import '../../models/usuario_login.dart';
import '../../components/commonAppBar/common_app_bar_controller.dart';
import '../../models/service_http_response.dart';

class LoginPageController extends GetxController {
  CommonAppBarController appBarControl = Get.put(CommonAppBarController());

  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  RxString msg = ''.obs;
  RxBool hayError = false.obs;
  RxBool isLoading = false.obs;

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

  // Método para iniciar sesión
  Future<void> goMainPage(BuildContext context) async {
    UsuarioService service = UsuarioService();
    String usuario = txtemail.text;
    String contrasena = txtpassword.text;
    UsuarioLogin usuarioLogin = UsuarioLogin(correo: usuario, contrasena: contrasena);

    isLoading.value = true; 

    try {
      // Esperar respuesta del servicio con timeout de 10 segundos
      ServiceHttpResponse? response = await service.login(usuarioLogin).timeout(Duration(seconds: 10));

      if (response != null && response.status == 200) {
        msg.value = 'Usuario y contraseña válidos';
        hayError.value = false;
        var idUsuario = response.body['idUsuario'];
        print('ID de Usuario: $idUsuario');
        appBarControl.updateIdUsuario(idUsuario);
        Future.delayed(Duration(seconds: 1), () {
          isLoading.value = false; 
          Navigator.pushNamed(context, '/home', arguments: {'idUsuario': idUsuario});  //enviar el idUsuario a la siguiente página
        });
      } else {
        isLoading.value = false;
        msg.value = response?.body ?? 'Correo o contraseña incorrectos';
        hayError.value = true;
      }
    } catch (e) {
      // Si ocurre un timeout o un error en la conexión
      isLoading.value = false;
      msg.value = 'No se pudo conectar con el servidor';
      hayError.value = true;
      showSnackbar('Error', msg.value);
    } finally {
      Future.delayed(Duration(seconds: 3), () {
        msg.value = '';
      });
    }
  }
}
