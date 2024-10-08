import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './profile_controller.dart';
import '../../components/common_app_bar.dart';
import '../../components/button.dart';
import '../../components/customTextfield.dart';
import '../../configs/colors.dart';

class ProfilePage extends StatelessWidget{
  ProfileController control = Get.put(ProfileController());

  @override
  Widget _buildBody(BuildContext context) {
  return SingleChildScrollView(
        child: Column(
          children: [
            Container( 
              height: 650.0,
              color: AppColors.backgroundColor5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        "Configura tu perfil de salud",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        left: 40.0,
                        right: 40.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 450.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0)),
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Customtextfield(
                                        label: 'Altura',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Customtextfield(
                                        label: 'Peso',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Customtextfield(
                                label: 'Sexo',
                            ),
                            SizedBox(height: 5.0),
                            Customtextfield(
                              label: 'Condiciones médicas',
                            ),
                            SizedBox(height: 5.0),
                            Customtextfield(
                              label: 'Alergias',
                            ),
                            SizedBox(height: 5.0),
                            Customtextfield(
                              label: 'Otros',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      title: "Guardar",
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      width: 200.0,
                    ),
                    SizedBox(height: 10.0),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Text(
                        "Ahora no",
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
