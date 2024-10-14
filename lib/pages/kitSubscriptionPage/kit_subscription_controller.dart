/*import 'package:flutter/material.dart';
import 'package:get/get.dart';


class KitSubscriptionController extends GetxController {
  TextEditingController subscriptionController = TextEditingController();
  TextEditingController paymethodController = TextEditingController();

  var subscriptionError = ''.obs;
  var paymethodError = ''.obs;

  // Inicializa las opciones
  final List<String> subscriptionOptions = ['3 meses', '6 meses', '12 meses'];
  final List<String> paymentOptions = ['Tarjeta de crédito/débito', 'Yape'];

  // Variables observables para los dropdowns, inicializadas
  var selectedSubscription = '3 meses'.obs;  // Valor inicial para suscripción
  var selectedPaymethod = 'Tarjeta de crédito/débito'.obs;  // Valor inicial para método de pago

  // Métodos de validación
  void validateSubscription() {
    if (selectedSubscription.value.isEmpty) {
      subscriptionError.value = 'Elija tipo de suscripción';
    } else {
      subscriptionError.value = '';
    }
  }

  void validatePaymethod() {
    if (selectedPaymethod.value.isEmpty) {
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

  @override
  void onClose() {
    subscriptionController.dispose();
    paymethodController.dispose();
  }
}*/