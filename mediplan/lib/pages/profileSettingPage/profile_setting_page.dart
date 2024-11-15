import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/pages/profileSettingPage/profile_setting_controller.dart';

import '../../components/commonAppBar/common_app_bar.dart';
import '../../components/button.dart';
import '../../components/customTextfield.dart';
import '../../configs/colors.dart';

class ProfileSettingPage extends StatelessWidget {
  ProfileSettingController control = Get.put(ProfileSettingController());

  @override
  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 650.0,
                color: AppColors.backgroundColor3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          "Configura tu perfil de salud",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          left: 40.0,
                          right: 40.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 450.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0)),
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Customtextfield(
                                          label: 'Altura',
                                          controller: control.alturaController,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Customtextfield(
                                          label: 'Peso',
                                          controller: control.pesoController,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Customtextfield(
                                label: 'Sexo',
                                controller: control.sexoController,
                              ),
                              SizedBox(height: 5.0),
                              Customtextfield(
                                label: 'Condiciones médicas',
                                controller: control.condicionesMedicasController,
                              ),
                              SizedBox(height: 5.0),
                              Customtextfield(
                                label: 'Alergias',
                                controller: control.alergiasController,
                              ),
                              SizedBox(height: 5.0),
                              Customtextfield(
                                label: 'Otros',
                                controller: control.otrosController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        title: "Guardar",
                        onPressed: () async {
                          await control.saveProfileData(context, guardarOpcionales: true);
                        },
                        width: 200.0,
                      ),
                      SizedBox(height: 10.0),
                      InkWell(
                        onTap: () async {
                          await control.saveProfileData(context, guardarOpcionales: false);
                        },
                        child: Text(
                          "Ahora no",
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Indicador de carga sobrepuesto
        Obx(() {
          if (control.isLoading.value) {
            return Container(
              color: Colors.black.withOpacity(0.6), // Fondo gris semitransparente
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            );
          }
          return SizedBox.shrink();
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: _buildBody(context),
    );
  }
}
