import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mediplan/pages/resetMSGPage/reset_msg_controller.dart';
import 'package:mediplan/pages/resetPasswordPage/reset_password_controller.dart';
import 'package:mediplan/pages/profileSettingPage/profile_setting_controller.dart';

import '../../common_app_bar.dart';
import '../../components/button.dart';
import '../../configs/colors.dart';

class ResetMsgPage extends StatelessWidget{
  ResetMsgController control = Get.put(ResetMsgController());

  @override
  Widget _buildBody(BuildContext context) {
  return SafeArea(
    child: Container(
      color: AppColors.backgroundColor3,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30.0),
                  Text('Hemos enviado un correo con las instrucciones para restaurar tu contraseña.', 
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.0),
                  Center(
                    child: Button(
                      title: 'Volver',
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      width: 200.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
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