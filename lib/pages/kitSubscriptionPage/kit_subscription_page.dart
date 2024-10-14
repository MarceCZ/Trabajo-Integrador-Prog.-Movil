/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/cart_controller.dart';
import 'package:mediplan/components/common_app_bar.dart';
import 'package:mediplan/configs/colors.dart';
import 'package:mediplan/components/stepProgress.dart';
import 'package:mediplan/pages/kitSubscriptionPage/kit_subscription_controller.dart';

class KitSubscriptionPage extends StatelessWidget {
  final KitSubscriptionController kitSubscriptionController =
      Get.put(KitSubscriptionController());
  final CartController cartController = Get.find<CartController>();

  @override
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    "Mi kit",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  StepProgress(currentStep: 3),
                  SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dropdown de suscripción
                        DropdownButton<String>(
                          hint: Text('Elige tu suscripción'),
                          value: kitSubscriptionController.selectedSubscription.value,
                          onChanged: (newValue) {
                            kitSubscriptionController.selectedSubscription.value = newValue!;
                            kitSubscriptionController.validateSubscription();
                          },
                          items: kitSubscriptionController.subscriptionOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                        ),
                        Obx(() => kitSubscriptionController.subscriptionError.value.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  kitSubscriptionController.subscriptionError.value,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox()),
                        SizedBox(height: 16.0),

                        // Dropdown de método de pago
                        DropdownButton<String>(
                          hint: Text('Método de pago'),
                          value: kitSubscriptionController.selectedPaymethod.value,
                          onChanged: (newValue) {
                            kitSubscriptionController.selectedPaymethod.value = newValue!;
                            kitSubscriptionController.validatePaymethod();
                          },
                          items: kitSubscriptionController.paymentOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                        ),
                        Obx(() => kitSubscriptionController.paymethodError.value.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  kitSubscriptionController.paymethodError.value,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox()),
                        SizedBox(height: 30.0),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Subtotal: S/ ${cartController.subtotal}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              Text(
                                'Costo de servicio: S/ ${cartController.subtotal * 0.2}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              SizedBox(height: 17.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total: ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  Text(
                                    'S/ ${cartController.subtotal * 1.2}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Botón de continuar
                  Button(
                    title: 'Confirmar',
                    onPressed: () {
                      // Validar el formulario al presionar el botón
                      if (kitSubscriptionController.validateForm()) {
                        Navigator.pushNamed(context, '/purchase-confirmation');
                      } else {}
                    },
                    width: 200.0,
                  ),
                  // Botón de cancelar
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: _buildBody(context),
      resizeToAvoidBottomInset: true,
    );
  }
}*/