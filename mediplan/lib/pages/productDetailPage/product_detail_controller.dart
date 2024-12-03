import 'package:get/get.dart';
import 'package:mediplan/models/producto_botica.dart';
import 'package:mediplan/services/producto_botica.dart';
import 'package:mediplan/components/cart_controller.dart';

class ProductDetailController extends GetxController {
  var quantity = 1.obs;
  var productDetail = Rxn<ProductoBotica>();
  final CartController cartController = Get.find<CartController>();

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void addToCart() {
    if (productDetail.value != null) {
      for (int i = 0; i < quantity.value; i++) {
        cartController.addToCart(productDetail.value!);
      }
      Get.snackbar(
        'Producto añadido',
        '${quantity.value} unidades añadidas al carrito',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
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
