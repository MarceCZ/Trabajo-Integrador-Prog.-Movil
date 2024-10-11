import 'package:get/get.dart';
import 'package:mediplan/models/producto_botica.dart';

class CartController extends GetxController {
  var cartItems = <ProductoBotica>[].obs;

  void addToCart(ProductoBotica producto) {
    cartItems.add(producto);
    update();
  }

  void removeFromCart(ProductoBotica producto) {
    cartItems.remove(producto);
  }

  void clearCart() {
    cartItems.clear();
  }

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => sum + item.precio);
  }

  int getProductCount(String nombre) {
    return cartItems.where((producto) => producto.nombre == nombre).length;
  }

}