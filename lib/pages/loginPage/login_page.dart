import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/pages/loginPage/login_page_controller.dart';

import '../../common_app_bar.dart';
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
            padding: EdgeInsets.only(
              left: 40.0,
              right: 40.0,
            ),
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
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Correo electrónico",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  TextField(
                    controller: control.txtemail,
                    decoration: InputDecoration(
                      labelText: 'example@email.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                  ),
                  SizedBox(height: 18.0),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Contraseña",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  TextField(
                    controller: control.txtpassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.0, left: 15.0),
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
                  Center(
                    child: Button(
                      title: 'Iniciar Sesión',
                      onPressed: () {
                      Navigator.pushNamed(context, '/main-page');
                      },
                      width: 200.0,
                    )
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
    return MaterialApp(
      home: Scaffold(
        appBar: CommonAppBar(),
        body: _buildBody(context),
      ),
    );
  }
}