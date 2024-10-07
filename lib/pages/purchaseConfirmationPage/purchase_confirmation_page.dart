import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/components/button.dart';
import 'package:mediplan/pages/loginPage/login_page_controller.dart';
import 'package:mediplan/pages/purchaseConfirmationPage/purchase_confirmation_controller.dart';

import '../../components/common_app_bar.dart';
import '../../configs/colors.dart';

class PurchaseConfirmationPage extends StatelessWidget {
  PurchaseConfirmationController control =
      Get.put(PurchaseConfirmationController());
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _body = _getBody(_selectedIndex);
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return _bodyPestana1();
      case 1:
        return Center(child: Text('Página 2'));
      case 2:
        return Center(child: Text('Página 3'));
      default:
        return Center(child: Text('Página 1'));
    }
  }

  void _nextPage() {
    setState(() {
      _selectedIndex = (_selectedIndex + 1) %
          3; // Avanza al siguiente índice, vuelve al 0 si es la última pestaña
      _body = _getBody(
          _selectedIndex); // Actualiza el contenido con la nueva pestaña
    });
  }

  @override
  Widget _buildBody(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _body, // Contenido de la pestaña actual
      floatingActionButton: FloatingActionButton(
        onPressed:
            _nextPage, // Llama al método para avanzar de pestaña cuando se presiona el botón
        child: Icon(Icons.arrow_forward), // Icono del botón
        tooltip: 'Siguiente Página', // Texto de ayuda al pasar el cursor
      ),
    ));
  }

  Widget_bodyPurchaseConfirmation() {
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
                      TextSpan(
                          text: "confirmado ",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          )),
                      TextSpan(
                        text: "y lo recibirás ",
                      ),
                      TextSpan(
                          text: "mensualmente",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          )),
                      TextSpan(
                        text: "!",
                      ),
                    ])),
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
    return MaterialApp(
      home: Scaffold(
        appBar: CommonAppBar(),
        body: _buildBody(context),
      ),
    );
  }
}
