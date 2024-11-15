import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/commonAppBar/common_app_bar.dart';
import '../../components/button.dart';
import '../../components/customTextfield.dart';
import '../../configs/colors.dart';
import 'sign_up_controller.dart';
import '../../components/customDateField.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController control = Get.put(SignUpController());

  @override
  void initState() {
    super.initState();
    // Limpiar todos los campos de texto cuando se inicie la página
    control.txtname.clear();
    control.txtlastname.clear();
    control.txtemail.clear();
    control.phonenumber.clear();
    control.txtpassword.clear();
    control.date.clear();
  }

  @override
  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Container(
            color: AppColors.backgroundColor3,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Regístrate",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Customtextfield(
                              label: 'Nombre',
                              controller: control.txtname,
                              hintText: 'Ingrese su(s) nombre(s)',
                            ),
                            Obx(() => control.nameError.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      control.nameError.value,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : SizedBox()),

                            SizedBox(height: 5.0),

                            Customtextfield(
                              label: 'Apellidos',
                              controller: control.txtlastname,
                              hintText: 'Ingrese su(s) apellido(s)',
                            ),
                            Obx(() => control.lastNameError.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      control.lastNameError.value,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : SizedBox()),

                            SizedBox(height: 5.0),

                            CustomDateField(
                              label: 'Fecha de nacimiento',
                              hintText: 'dd/mm/aaaa',
                              controller: control.date,
                              onCalendarTap: () => control.selectDate(context),
                            ),
                            Obx(() => control.dateError.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      control.dateError.value,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : SizedBox()),

                            SizedBox(height: 5.0),

                            Customtextfield(
                              label: 'Correo electrónico',
                              controller: control.txtemail,
                              hintText: 'example@example.com',
                            ),
                            Obx(() => control.emailError.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      control.emailError.value,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : SizedBox()),

                            SizedBox(height: 5.0),

                            Customtextfield(
                              label: 'Celular',
                              controller: control.phonenumber,
                              hintText: 'Ingrese su número de celular',
                            ),
                            Obx(() => control.phoneError.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      control.phoneError.value,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : SizedBox()),

                            SizedBox(height: 5.0),

                            Customtextfield(
                              label: 'Contraseña',
                              controller: control.txtpassword,
                              obscureText: true,
                              hintText: 'Ingrese su contraseña',
                            ),
                            Obx(() => control.passwordError.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      control.passwordError.value,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : SizedBox()),

                            SizedBox(height: 20.0),

                            // Botón de registro
                            Center(
                              child: Button(
                                title: 'Registrarme',
                                onPressed: () async {
                                  await control.registerUser(context);
                                },
                                width: 200.0,
                              ),
                            ),

                            SizedBox(height: 5.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '¿Ya tienes una cuenta?',
                                  style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(width: 5.0),
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Overlay de carga
        Obx(() {
          if (control.isLoading.value) {
            return Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            );
          }
          return SizedBox.shrink();
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: _buildBody(context),
      resizeToAvoidBottomInset: true,
    );
  }
}
