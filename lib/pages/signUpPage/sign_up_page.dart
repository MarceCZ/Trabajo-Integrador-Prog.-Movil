import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../common_app_bar.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Regístrate", 
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
                  height: 600.0,
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