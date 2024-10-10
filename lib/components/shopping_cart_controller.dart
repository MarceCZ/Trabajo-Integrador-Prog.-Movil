import 'package:get/get.dart';
import 'package:mediplan/models/producto_botica.dart';

class ShoppingCartController extends GetxController {
  var cartItems = <ProductoBotica>[].obs;

  void addItem(ProductoBotica item) {
    cartItems.add(item);
  }

  void removeItem(ProductoBotica item) {
    cartItems.remove(item);
  }
}