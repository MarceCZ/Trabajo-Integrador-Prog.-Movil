import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  var quantity = 1.obs;

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
}
