import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/cart_controller.dart';
import 'package:mediplan/components/commonAppBar/common_app_bar.dart';
import 'package:mediplan/configs/colors.dart';
import 'package:mediplan/components/stepProgress.dart';
import 'package:mediplan/pages/kitSubscriptionPage/kit_subscription_controller.dart';
import 'package:mediplan/components/custom_dropdown.dart';

class KitSubscriptionPage extends StatefulWidget {
  @override
  _KitSubscriptionPageState createState() => _KitSubscriptionPageState();
}

class _KitSubscriptionPageState extends State<KitSubscriptionPage> {
  final KitSubscriptionController kitSubscriptionController = Get.put(KitSubscriptionController());
  final CartController cartController = Get.find<CartController>();

  @override
  void dispose() {
    // Elimina el controlador al salir de la página
    Get.delete<KitSubscriptionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: CommonAppBar(),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              const Text(
                "Mi kit",
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              StepProgress(currentStep: 3),
              const SizedBox(height: 20.0),
              _buildSubscriptionContainer(),
              const SizedBox(height: 20.0),
              _buildConfirmButton(context),
              _buildCancelButton(),
            ],
          ),
        ),
      ),
    ),
    resizeToAvoidBottomInset: true,
  );
}

  Widget _buildSubscriptionContainer() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.0),
    ),
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyledDropdown(
          hint: 'Elige tu suscripción',
          options: kitSubscriptionController.subscriptionOptions,
          selectedValue: kitSubscriptionController.selectedSubscription,
          validate: kitSubscriptionController.validateSubscription,
        ),
        _buildSubscriptionError(),
        const SizedBox(height: 16.0),
        StyledDropdown(
          hint: 'Método de pago',
          options: kitSubscriptionController.paymentOptions,
          selectedValue: kitSubscriptionController.selectedPaymethod,
          validate: kitSubscriptionController.validatePaymethod,
        ),
        _buildPaymentMethodError(),
        const SizedBox(height: 30.0),
        _buildTotalAmount(),
      ],
    ),
  );
}

  Widget _buildSubscriptionError() {
    return Obx(() => kitSubscriptionController.subscriptionError.value.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              kitSubscriptionController.subscriptionError.value,
              style: const TextStyle(color: Colors.red),
            ),
          )
        : const SizedBox());
  }

  Widget _buildPaymentMethodError() {
    return Obx(() => kitSubscriptionController.paymethodError.value.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              kitSubscriptionController.paymethodError.value,
              style: const TextStyle(color: Colors.red),
            ),
          )
        : const SizedBox());
  }

  Widget _buildTotalAmount() {
    return Center(
      child: Column(
        children: [
          Text(
            'Subtotal: S/ ${(cartController.subtotal).toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          Text(
            'Costo de servicio: S/ ${(cartController.subtotal * 0.2).toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 17.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Total: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                'S/ ${ (cartController.subtotal * 1.2).toStringAsFixed(2) }',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Button(
      title: 'Confirmar',
      onPressed: () {
        if (kitSubscriptionController.validateForm()) {
          Navigator.pushNamed(context, '/purchase-confirmation');
        }
      },
      width: 200.0,
      backgroundColor: AppColors.primaryColor,
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () {
        Get.back();
        kitSubscriptionController.selectedSubscription.value = null;
        kitSubscriptionController.selectedPaymethod.value = null;
      },
      child: const Text(
        'Cancelar',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}