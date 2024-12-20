import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/pages/loginPage/login_page_controller.dart';
import '../../components/commonAppBar/common_app_bar.dart';
import '../../components/customTextfield.dart';
import '../../configs/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPageController control = Get.put(LoginPageController());

  @override
  void initState() {
    super.initState();
    control.txtemail.clear();
    control.txtpassword.clear();
  }

  @override
  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Container(
            color: AppColors.backgroundColor3,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                                hintText: 'example@example.com',
                              ),
                              SizedBox(height: 18.0),
                              Customtextfield(
                                label: "Contraseña",
                                controller: control.txtpassword,
                                obscureText: true,
                                hintText: 'Ingrese su contraseña',
                              ),
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
                                    : Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              control.msg.value,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: (control.hayError.value) ? Colors.red : Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
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
                                      style: TextStyle(fontSize: 16.0),
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
              ),
            ),
          ),
        ),
        // Overlay de carga
        Obx(() {
          if (control.isLoading.value) {
            return Container(
              color: Colors.black.withOpacity(0.6),
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
      resizeToAvoidBottomInset: true,
    );
  }
}
