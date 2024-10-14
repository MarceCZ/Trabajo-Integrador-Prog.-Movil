import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/pages/loginPage/login_page_controller.dart';
import 'package:mediplan/pages/purchaseConfirmationPage/purchase_confirmation_controller.dart';

import '../../components/common_app_bar.dart';
import '../../components/common_drawer.dart';
import '../../configs/colors.dart';

class PurchaseConfirmationPage extends StatelessWidget {
    PurchaseConfirmationController control = Get.put(PurchaseConfirmationController());

  @override
 Widget _buildBody(BuildContext context) {
  return SafeArea(
    child: Container(
      color: AppColors.backgroundColor3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: Colors.white,
                  fontSize: 40.0,
              ),
              children: <TextSpan>[
              TextSpan(
                text: "¡Tu kit ha sido ", 
              ),
              TextSpan(text: "confirmado ",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                )
              ),
              TextSpan(
                text: "y lo recibirás ", 
              ),
              TextSpan(text: "mensualmente",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                )
              ),
              TextSpan(
                text: "!", 
              ),
            ])
          ),
          SizedBox(height: 60.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0), 
            child: Text(
              'Puedes hacer cualquier cambio hasta 2 semanas antes de su envío. Solo ingrese a su perfil.',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.0),
          Button(
            title: 'Aceptar', 
            onPressed: () {
              Navigator.pushNamed(context, '/main-page');
            },
            width: 180.0,
            backgroundColor: AppColors.backgroundColor2,
            textColor: AppColors.textColor,

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
        endDrawer: CommonDrawer(),
        body: _buildBody(context),
      
    );
  }
}