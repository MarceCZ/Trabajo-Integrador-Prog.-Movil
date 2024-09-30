import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import '../../configs/colors.dart';
import 'presentation_controller.dart';
import '../../common_app_bar.dart';

class PresentationPage extends StatelessWidget {
  PresentationController control = Get.put(PresentationController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            color: AppColors.backgroundColor3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Image.asset('assets/img/logo3.png', height: 170.0),
                  SizedBox(height: 30.0),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                         fontSize: 35.0,
                      ),
                      children: <TextSpan>[
                      TextSpan(
                        text: "Tu salud ", 
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        )
                      ),
                      TextSpan(text: "a un click de distancia"),
                    ])
                  ),
                  SizedBox(height: 20.0),
                  Text("Personaliza y recibe tus medicinas esenciales cada mes con comodidad y confianza.", 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Center(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Button(
                    title: "Empieza hoy",
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign-up');
                    },
                    width: 200.0,
                  ),
                  SizedBox(height: 15.0),
                  Text("¿Ya tienes una cuenta?", 
                    style: TextStyle(
                      color: AppColors.secondaryColor, 
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center
                  ),
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
                  )],
              )
            )
          )
        )
      ]
    ));
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