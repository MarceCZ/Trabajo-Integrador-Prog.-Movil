import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/models/kit_producto.dart';
import 'package:mediplan/models/kit.dart';
import 'package:mediplan/services/kit_producto_service.dart';
import 'package:mediplan/services/kit_service.dart';
import '../../components/commonAppBar/common_app_bar_controller.dart';
import 'package:mediplan/models/service_http_response.dart';

class KitSettingController extends GetxController {
  final CommonAppBarController appBarControl = Get.put(CommonAppBarController());
  int idSuscripcion = 0;
  int idKit = 0;
  KitProductoService kitProductoService = KitProductoService();
  KitService kitService = KitService();
  var productos = <KitProducto>[].obs;

  var tipo = ''.obs;
  var fechaInicio = ''.obs;
  var fechaFin = ''.obs;
  var total = 0.0.obs;
  var pago = ''.obs;
  var fechaEntrega = ''.obs;
  var estado = ''.obs;
  var departamento = ''.obs;
  var distrito = ''.obs;
  var direccion = ''.obs;
  var otro = ''.obs;

  var errorMessage = ''.obs;
  void listarProductos() async {
    try {
      productos.value = await kitProductoService.fetchByKit(appBarControl.idUsuario.value);
      productos.refresh();
      print("Productos cargados: ${productos}");
    } catch (e) {
      print("Error al listar productos: $e");
    }
  }

  void buscarKit() async {
    final kit = await kitService.fetchOneUser(appBarControl.idUsuario.value);
    if (kit != null) {
      idKit = kit.id;
      idSuscripcion = kit.idSuscripcion!;
      tipo.value = kit.tipo;
      fechaInicio.value = DateFormat('dd/MM/yyyy').format(kit.fechaInicio);
      fechaFin.value = DateFormat('dd/MM/yyyy').format(kit.fechaFin);
      total.value = kit.total;
      pago.value = kit.metodoPago;
      fechaEntrega.value =  DateFormat('dd/MM/yyyy').format(kit.fechaEntrega);
      estado.value = kit.estado;
      departamento.value = kit.departamento;
      distrito.value = kit.distrito;
      direccion.value = kit.direccion;
      otro.value = kit.otro;
      print('Kit encontrado: $kit');
    }
  }


  void getKit() {
    print(idKit);
    buscarKit();
    Future.delayed(Duration(seconds: 1), () {
      listarProductos();
    });
  }

  void cancelarSuscripcion() async {
    
    try {
      ServiceHttpResponse? response =
          await kitService.cancelarSuscripcion(idSuscripcion).timeout(Duration(seconds: 10));

      //isLoading.value = false;
      if (response != null && response.status == 200) {
       // buscarUsuario();
      } else {
        errorMessage.value =
            response?.body ?? 'Error al cancelar la suscripción';
        //showSnackbar('Error', errorMessage.value);
      }
    } catch (e) {
      //isLoading.value = false;
      errorMessage.value =
          'No se pudo conectar con el servidor. Verifica tu conexión.';
      //showSnackbar('Error', errorMessage.value);
    }

    print('suscripcion cancelada');
    Future.delayed(Duration(seconds: 1), () {
      //buscarUsuario();
    });
  }
}
