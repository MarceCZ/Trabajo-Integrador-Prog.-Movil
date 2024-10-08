import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../components/common_app_bar.dart';
import '../../components/button.dart';
import '../../components/customTextfield.dart';
import '../../configs/colors.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
    SignUpController control = Get.put(SignUpController());

  @override
   Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.backgroundColor3,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Regístrate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    height: 610.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Customtextfield(
                          label: 'Nombre',
                          hintText: 'Ingrese su(s) nombre(s)'
                        ),
                        SizedBox(height: 5.0),
                        Customtextfield(
                          label: 'Apellidos',
                          hintText: 'Ingrese su(s) apellido(s)'
                        ),
                        SizedBox(height: 5.0),
                        Customtextfield(
                          label: 'Fecha de nacimiento',
                          hintText: 'dd/mm/aaaa'
                        ),
                        SizedBox(height: 5.0),
                        Customtextfield(
                          label: 'Correo electrónico',
                          hintText: 'example@example.com'
                        ),
                        SizedBox(height: 5.0),
                        Customtextfield(
                          label: 'Celular',
                          hintText: 'Ingrese su número de celular'
                        ),
                        SizedBox(height: 5.0),
                        Customtextfield(
                          label: 'Contraseña',
                          obscureText: true,
                          hintText: 'Ingrese su contraseña'
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Button(
                            title: 'Registrarme',
                            onPressed: () {
                              Navigator.pushNamed(context, '/profile-setting');
                            },
                            width: 200.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '¿Ya tienes una cuenta?',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                "Inicia sesión",
                                style: TextStyle(
                                  color: AppColors.customGreen,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
    return MaterialApp(
      home: Scaffold(
        appBar: CommonAppBar(),
        body: _buildBody(context),
      ),
    );
  }
}