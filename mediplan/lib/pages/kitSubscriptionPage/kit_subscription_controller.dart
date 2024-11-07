import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KitSubscriptionController extends GetxController {
  // Variables observables para los dropdowns, inicializadas como null
  var selectedSubscription =
      Rx<String?>(null); // Valor inicial para suscripción
  var selectedPaymethod =
      Rx<String?>(null); // Valor inicial para método de pago

  var subscriptionError = ''.obs; // Mensaje de error para suscripción
  var paymethodError = ''.obs; // Mensaje de error para método de pago

  // Inicializa las opciones
  final List<String> subscriptionOptions = ['3 meses', '6 meses', '12 meses'];
  final List<String> paymentOptions = [
    'Tarjeta de crédito',
    'Tarjeta de débito',
    'Yape'
  ];

  // Métodos de validación
  void validateSubscription() {
    if (selectedSubscription.value == null) {
      subscriptionError.value = 'Elija tipo de suscripción';
    } else {
      subscriptionError.value = ''; // Limpia el error si hay selección
    }
  }

  void validatePaymethod() {
    if (selectedPaymethod.value == null) {
      paymethodError.value = 'Elija método de pago';
    } else {
      paymethodError.value = ''; // Limpia el error si hay selección
    }
  }

  bool validateForm() {
    validateSubscription();
    validatePaymethod();
    return subscriptionError.value.isEmpty && paymethodError.value.isEmpty;
  }

}
