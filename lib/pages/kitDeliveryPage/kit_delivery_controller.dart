import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KitDeliveryController extends GetxController {
  // Controladores de los campos de texto
  TextEditingController departmentController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController additionalAddressController = TextEditingController();

  // Variables observables para los mensajes de error
  var departmentError = ''.obs;
  var districtError = ''.obs;
  var addressError = ''.obs;
  var additionalAddressError = ''.obs;

  // Métodos de validación para cada campo
  void validateDepartment() {
    if (departmentController.text.isEmpty) {
      departmentError.value = 'El campo departamento está vacío';
    } else {
      departmentError.value = '';
    }
  }

  void validateDistrict() {
    if (districtController.text.isEmpty) {
      districtError.value = 'El campo distrito está vacío';
    } else {
      districtError.value = '';
    }
  }

  void validateAddress() {
    if (addressController.text.isEmpty) {
      addressError.value = 'El campo dirección está vacío';
    } else {
      addressError.value = '';
    }
  }

  void validateAdditionalAddress() {
    if (additionalAddressController.text.isEmpty) {
      additionalAddressError.value = 'El campo dirección adicional está vacío';
    } else {
      additionalAddressError.value = '';
    }
  }

  // Validar todos los campos del formulario
  bool validateForm() {
    validateDepartment();
    validateDistrict();
    validateAddress();
    validateAdditionalAddress();

    // Devuelve true si no hay errores en los campos
    return departmentError.value.isEmpty &&
        districtError.value.isEmpty &&
        addressError.value.isEmpty &&
        additionalAddressError.value.isEmpty;
  }

  @override
  void onClose() {
    // Limpiar los controladores cuando se cierre el controlador
    departmentController.dispose();
    districtController.dispose();
    addressController.dispose();
    additionalAddressController.dispose();
    super.onClose();
  }
}