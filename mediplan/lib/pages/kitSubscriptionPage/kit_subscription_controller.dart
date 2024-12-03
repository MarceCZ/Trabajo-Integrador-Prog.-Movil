import 'dart:convert';

import 'package:get/get.dart';
import 'package:mediplan/components/cart_controller.dart';
import 'package:mediplan/pages/kitDeliveryPage/kit_delivery_controller.dart';
import 'package:mediplan/services/subscription_service.dart';

class KitSubscriptionController extends GetxController {
  final CartController cartController = Get.find<CartController>();
  final KitDeliveryController deliveryController = Get.find<KitDeliveryController>();
  final SubscriptionService subscriptionService = SubscriptionService();

  var selectedSubscription = Rx<String?>(null);
  var selectedPaymethod = Rx<String?>(null);

  var subscriptionError = ''.obs;
  var paymethodError = ''.obs;

  final List<String> subscriptionOptions = ['3 meses', '6 meses', '12 meses'];
  final List<String> paymentOptions = ['Tarjeta de crédito', 'Tarjeta de débito', 'Yape'];

  void validateSubscription() {
    if (selectedSubscription.value == null) {
      subscriptionError.value = 'Elija tipo de suscripción';
    } else {
      subscriptionError.value = '';
    }
  }

  void validatePaymethod() {
    if (selectedPaymethod.value == null) {
      paymethodError.value = 'Elija método de pago';
    } else {
      paymethodError.value = '';
    }
  }

  bool validateForm() {
    validateSubscription();
    validatePaymethod();
    return subscriptionError.value.isEmpty && paymethodError.value.isEmpty;
  }

  Future<void> confirmSubscription() async {
  try {
    // Consolidar productos en un solo mapa
    final Map<int, int> consolidatedProducts = {};
    for (var producto in cartController.cartItems) {
      consolidatedProducts.update(
        producto.id,
        (existingQuantity) => existingQuantity + 1, // Incrementa por cada instancia del producto
        ifAbsent: () => 1, // Inicia con 1 si no existe
      );
    }

    // Transformar el mapa consolidado en una lista para enviarla al backend
    final List<Map<String, dynamic>> productos = consolidatedProducts.entries.map((entry) {
      return {
        'id_producto': entry.key,
        'cantidad': entry.value,
      };
    }).toList();

    // Validar dirección
    if (deliveryController.departmentController.text.isEmpty ||
        deliveryController.districtController.text.isEmpty ||
        deliveryController.addressController.text.isEmpty ||
        deliveryController.additionalAddressController.text.isEmpty) {
      throw Exception("Complete todos los campos de la dirección correctamente.");
    }

    // Construir datos para el backend
    final Map<String, dynamic> subscriptionData = {
      'usuario_id': 1,
      'tipo_suscripcion': _getSubscriptionType(selectedSubscription.value),
      'metodo_pago': selectedPaymethod.value,
      'productos': productos,
      'direccion': {
        'departamento': deliveryController.departmentController.text,
        'distrito': deliveryController.districtController.text,
        'direccion': deliveryController.addressController.text,
        'numero': deliveryController.additionalAddressController.text,
      },
    };

    print("Datos enviados al backend: ${jsonEncode(subscriptionData)}");

    // Enviar datos al backend
    final response = await subscriptionService.createSubscription(subscriptionData);

    // Mostrar mensaje de éxito
    Get.snackbar('Éxito', response['mensaje'], snackPosition: SnackPosition.BOTTOM);

    // Limpiar datos después de confirmar
    _clearAllData();
  } catch (e) {
    Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
  }
}


  int _getSubscriptionType(String? subscription) {
    switch (subscription) {
      case '3 meses':
        return 1;
      case '6 meses':
        return 2;
      case '12 meses':
        return 3;
      default:
        return 0;
    }
  }

  void _clearAllData() {
    cartController.clearCart();
    deliveryController.departmentController.clear();
    deliveryController.districtController.clear();
    deliveryController.addressController.clear();
    deliveryController.additionalAddressController.clear();
    selectedSubscription.value = null;
    selectedPaymethod.value = null;
  }
}
