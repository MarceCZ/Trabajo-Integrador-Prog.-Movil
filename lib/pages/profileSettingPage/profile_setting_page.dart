import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/pages/profileSettingPage/profile_setting_controller.dart';

import '../../common_app_bar.dart';
import '../../components/button.dart';
import '../../configs/colors.dart';

class ProfileSettingPage extends StatelessWidget{
  ProfileSettingController control = Get.put(ProfileSettingController());

  @override
  Widget _buildBody(BuildContext context) {
  return SafeArea(
    child: Column(
      children: [
        Expanded(
          flex: 8,
          child: Container(
            color: AppColors.backgroundColor3,
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
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "Altura",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 20.0),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(width: 20.0), 
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "Peso",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 20.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Sexo",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            )
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Condiciones médicas",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            )
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Alergias",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            )
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Otros",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            )
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
        Expanded(
          flex: 2,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    title: "Guardar",
                    onPressed: () {
                      Get.toNamed('/main-page');
                    },
                    width: 200.0,
                  ),
                  SizedBox(height: 10.0),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/main-page');
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
        ),
      ],
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
