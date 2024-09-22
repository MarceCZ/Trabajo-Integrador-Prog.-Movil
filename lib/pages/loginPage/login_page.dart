import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Inicia Sesión", 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold
                )
              ),
              Padding(padding: EdgeInsets.only(
                top: 30.0,
                left: 40.0,
                right: 40.0,
              ),
                child: Container(
                  width: double.infinity,
                  height: 400.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Column(
                  children: [
                  ],
                ),
              ),
              ),
              
            ],)
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