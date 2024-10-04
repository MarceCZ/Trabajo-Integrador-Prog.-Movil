import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mediplan/pages/resetPasswordPage/reset_password_controller.dart';
import 'package:mediplan/pages/profileSettingPage/profile_setting_controller.dart';

import '../../components/common_app_bar.dart';
import '../../components/button.dart';
import '../../components/customTextfield.dart';
import '../../configs/colors.dart';

class ResetPasswordPage extends StatelessWidget{
  ResetPasswordController control = Get.put(ResetPasswordController());

   @override
  Widget _buildBody(BuildContext context) {
  return SafeArea(
      child: Container(
        color: AppColors.backgroundColor3,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Recuperar mi contraseña",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
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
                  Text('Ingrese el correo electrónico con el que te registraste.', 
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.0),
                  Customtextfield(
                          label: 'Correo electrónico',
                          hintText: 'example@example.com'
                  ),
                  SizedBox(height: 40.0),
                  Center(
                    child: Button(
                      title: 'Enviar',
                      onPressed: () {
                        Navigator.pushNamed(context, '/reset-msg');
                      },
                      width: 200.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Center(
                      child: Text(
                        "Volver",
                        style: TextStyle(
                          color: AppColors.customGreen,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
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
        ),
      ),
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