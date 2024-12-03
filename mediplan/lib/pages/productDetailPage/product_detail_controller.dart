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

  Future<void> cargarProductDetail(int id) async {
    print("ID RECIBIDOOOOOOOO-----: $id");
    ProductoBoticaService service = ProductoBoticaService();
    ProductoBotica producto = await service.fetchById(id);
    print("Producto cargado en el controlador: $producto");
    productDetail.value = producto;
    print("Producto asignado a productDetail: ${productDetail.value}");
  }
}
