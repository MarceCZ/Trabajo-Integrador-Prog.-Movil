import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/models/kit_producto.dart';
import 'package:mediplan/models/kit.dart';
import 'package:mediplan/services/kit_producto_service.dart';
import 'package:mediplan/services/kit_service.dart';
import '../../components/commonAppBar/common_app_bar_controller.dart';

class KitSettingController extends GetxController {
  final CommonAppBarController appBarControl = Get.put(CommonAppBarController());
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

  void listarProductos() async {
    try {
      productos.value = await kitProductoService.fetchByKit(idKit);
      productos.refresh();
      print("Productos cargados: ${productos}");
    } catch (e) {
      print("Error al listar productos: $e");
    }
  }

  void buscarKit() async {
    final kit = await kitService.fetchOneUser(appBarControl.usuario.value.idUsuario);
    if (kit != null) {
      idKit = kit.id;
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
}
