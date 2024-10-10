import 'package:get/get.dart';
import 'package:mediplan/models/producto_botica.dart';
import 'package:mediplan/services/producto_botica.dart';

class ProductDetailController extends GetxController {
  var quantity = 1.obs;
  var productDetail = Rxn<ProductoBotica>();

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void addToCart() {
    // Lógica para agregar el producto al carrito
    Get.snackbar(
      'Producto añadido',
      'El producto ha sido añadido al carrito con éxito',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> cargarProductDetail(int id) async{
      ProductoBoticaService service = ProductoBoticaService();
      List<ProductoBotica> productos = await service.fetchAll();
      productDetail.value = productos.firstWhere((producto) => producto.id == id);
  }
}
