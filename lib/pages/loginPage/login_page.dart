import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/components/customTextfield.dart';
import 'package:mediplan/pages/loginPage/login_page_controller.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_texfield.dart';
import '../../configs/colors.dart';

class LoginPage extends StatelessWidget {
    LoginPageController control = Get.put(LoginPageController());

  @override
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.backgroundColor3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Inicia Sesión",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                width: double.infinity,
                height: 400.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Customtextfield(
                      label: 'Correo electrónico',
                      controller: control.txtemail,
                      hintText: 'example@example.com'
                    ),
                    SizedBox(height: 18.0),
                    Customtextfield(
                      label: "Contraseña",
                      controller: control.txtpassword,
                      obscureText: true,
                      hintText: 'Ingrese su contraseña'),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, left: 15.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/reset-password');
                        },
                        child: Text(
                          "Olvidé mi contraseña",
                          style: TextStyle(
                            color: AppColors.customGreen,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Obx(() {
                      return (control.msg.value == '')
                          ? SizedBox()
                          : Column(
                              children: [
                                Center(
                                  child: Text(
                                    control.msg.value,
                                    style: TextStyle(
                                      color: (control.hayError.value)
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                )
                              ],
                            );
                    }),
                    Center(
                      child: Button(
                        title: 'Iniciar Sesión',
                        onPressed: () {
                          control.goMainPage(context);
                        },
                        width: 230.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '¿Aún no tienes una cuenta?',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/sign-up');
                            },
                            child: Text(
                              'Regístrate',
                              style: TextStyle(
                                color: AppColors.customGreen,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CommonAppBar(),
        body: _buildBody(context),
      );
  }
}