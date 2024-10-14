import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/common_app_bar.dart';
import 'package:mediplan/configs/colors.dart';
import 'package:mediplan/components/stepProgress.dart';
import 'package:mediplan/pages/kitDeliveryPage/kit_delivery_controller.dart';
import 'package:mediplan/components/customTextfield.dart';

class KitDeliveryPage extends StatelessWidget {
  final KitDeliveryController kitProductsController =
      Get.put(KitDeliveryController());

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
                  StepProgress(currentStep: 2),
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
                        // Departamento
                        Customtextfield(
                          label: 'Departamento',
                          controller:
                              kitProductsController.departmentController,
                        ),
                        Obx(() => kitProductsController
                                .departmentError.value.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  kitProductsController.departmentError.value,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox()),
                        SizedBox(height: 16.0),

                        // Distrito
                        Customtextfield(
                          label: 'Distrito',
                          controller: kitProductsController.districtController,
                        ),
                        Obx(() =>
                            kitProductsController.districtError.value.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      kitProductsController.districtError.value,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : SizedBox()),
                        SizedBox(height: 16.0),

                        // Dirección
                        Customtextfield(
                          label: 'Dirección',
                          controller: kitProductsController.addressController,
                        ),
                        Obx(() =>
                            kitProductsController.addressError.value.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      kitProductsController.addressError.value,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : SizedBox()),
                        SizedBox(height: 16.0),

                        // Dpt/No de casa/Otro
                        Customtextfield(
                          label: 'Dpt/No de casa/Otro',
                          controller:
                              kitProductsController.additionalAddressController,
                        ),
                        Obx(() => kitProductsController
                                .additionalAddressError.value.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  kitProductsController
                                      .additionalAddressError.value,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox()),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Botón de continuar
                  Button(
                    title: 'Continuar',
                    onPressed: () {
                      // Validar el formulario al presionar el botón
                      //if (kitProductsController.validateForm()) {
                        //Navigator.pushNamed(context, '/kit-subscription');
                     // } else {}
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
}