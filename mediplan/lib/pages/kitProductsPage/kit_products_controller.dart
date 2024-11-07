import 'package:get/get.dart';
import 'package:mediplan/components/cart_controller.dart';

class KitProductsController extends GetxController {
  final CartController cartController = Get.find<CartController>();

  double get subtotal => cartController.subtotal;

}