import 'package:get/get.dart';
import 'package:mediplan/models/producto_botica.dart';
import 'package:mediplan/services/producto_botica.dart';

class HomeController extends GetxController {
  ProductoBoticaService productoService = ProductoBoticaService();
  var productos = <ProductoBotica>[].obs;

  HomeController() {
    listarProductos();
  }

  void listarProductos() async {
    try {
      productos.value = await productoService.fetchAll();
      productos.refresh();
      print("Productos cargados: ${productos.length}");
    } catch (e) {
      print("Error al listar productos: $e");
    }
  }
}