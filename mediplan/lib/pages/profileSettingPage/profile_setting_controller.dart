import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mediplan/services/usuario_service.dart';
import '../../models/usuario_login.dart';
import '../../models/service_http_response.dart';
import '../../components/commonAppBar/common_app_bar_controller.dart';
import '../../models/usuario_signUp.dart';

class ProfileSettingController extends GetxController {
  CommonAppBarController appBarControl = Get.put(CommonAppBarController());
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController sexoController = TextEditingController();
  TextEditingController condicionesMedicasController = TextEditingController();
  TextEditingController alergiasController = TextEditingController();
  TextEditingController otrosController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Método para mostrar un snackbar en caso de error
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

  // Método para guardar con datos opcionales y timeout
  Future<void> saveProfileData(BuildContext context, {bool guardarOpcionales = true}) async {
    Map<String, dynamic> userData = Get.arguments;

    String? altura = guardarOpcionales && alturaController.text.isNotEmpty ? alturaController.text : null;
    String? peso = guardarOpcionales && pesoController.text.isNotEmpty ? pesoController.text : null;
    String? sexo = guardarOpcionales && sexoController.text.isNotEmpty ? sexoController.text : null;
    String? condicionesMedicas = guardarOpcionales && condicionesMedicasController.text.isNotEmpty ? condicionesMedicasController.text : null;
    String? alergias = guardarOpcionales && alergiasController.text.isNotEmpty ? alergiasController.text : null;
    String? otros = guardarOpcionales && otrosController.text.isNotEmpty ? otrosController.text : null;

    UsuarioSignUp usuario = UsuarioSignUp(
      nombres: userData['nombres'],
      apellidos: userData['apellidos'],
      correo: userData['correo'],
      celular: userData['celular'],
      fechaNacimiento: userData['fechaNacimiento'],
      contrasena: userData['contrasena'],
      altura: altura,
      peso: peso,
      sexo: sexo,
      condicionesMedicas: condicionesMedicas,
      alergias: alergias,
      otros: otros,
    );

    UsuarioService service = UsuarioService();
    isLoading.value = true; // Mostrar indicador de carga

    try {
      // Petición con timeout de 10 segundos
      ServiceHttpResponse? response = await service.registerUser(usuario).timeout(Duration(seconds: 10));
      UsuarioLogin usuarioLogin = UsuarioLogin(correo:  userData['correo'], contrasena: userData['contrasena']);

      isLoading.value = false;

      if (response != null && response.status == 200) {
        response = await service.login(usuarioLogin).timeout(Duration(seconds: 10));
        if (response != null && response.status == 200) {
          appBarControl.updateIdUsuario(response.body['idUsuario']);
          Get.toNamed('/home');
        } 
      } else {
        errorMessage.value = response?.body ?? 'No se pudo guardar la información.';
        showSnackbar('Error', errorMessage.value);
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'No se pudo conectar con el servidor. Verifica tu conexión.';
      showSnackbar('Error', errorMessage.value);
    }
  }
}
