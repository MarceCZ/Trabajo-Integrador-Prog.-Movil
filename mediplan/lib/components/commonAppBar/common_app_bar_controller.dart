import '../../models/usuario.dart';
import 'package:get/get.dart';

class CommonAppBarController extends GetxController {
  
  var usuario = Usuario(idUsuario: 0, correo: '').obs;

  void updateUsuario(Usuario u) {
    Future.delayed(Duration(seconds: 1), () {
      print('¡1 segundos han pasado!');
      // Aquí puedes colocar el código que deseas ejecutar después de 5 segundos.
      usuario.update((val) {
        val?.idUsuario = u.idUsuario;
        val?.correo = u.correo;
        val?.nombres = u.nombres;
        val?.apellidos = u.apellidos;
        val?.celular = u.celular;
        val?.fechaNacimiento = u.fechaNacimiento;
        val?.altura = u.altura;
        val?.peso = u.peso;
        val?.condicionesMedicas = u.condicionesMedicas;
        val?.alergias = u.alergias;
        val?.otros = u.otros;
        val?.sexo = u.sexo;
      });
    });
  }
}