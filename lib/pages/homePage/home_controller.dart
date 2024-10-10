import 'package:get/get.dart';
import 'package:mediplan/models/producto_botica.dart';
import 'package:mediplan/models/botica.dart';
import 'package:mediplan/services/botica.dart';
import 'package:mediplan/services/producto_botica.dart';

class HomeController extends GetxController {
  ProductoBoticaService productoService = ProductoBoticaService();
  var productos = <ProductoBotica>[].obs;

  BoticaService boticaService = BoticaService();
  var boticas = <Botica>[].obs;

  HomeController() {
    listarProductos();
    listarBoticas();
  }

  void listarProductos() async {
    productos.value = await productoService.fetchAll();
    productos.refresh();
  }

  void listarBoticas() async {
    boticas.value = await boticaService.fetchAll();
    boticas.refresh();
  }
}
