import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplan/pages/resetPasswordPage/reset_password_controller.dart';
import '../../components/commonAppBar/common_app_bar.dart';
import '../../components/ResetPasswordPage/reset_password_form.dart';
import '../../components/ResetPasswordPage/confirmation_msg.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final ResetPasswordController control = Get.put(ResetPasswordController());

  @override
  void initState() {
    super.initState();
    // Restablece el estado al cargar la página
    control.isEmailSent.value = false;
    control.txtemail.clear();
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      if (control.isLoading.value) {
        // Mostrar el indicador de carga sobre el contenido
        return Stack(
          children: [
            // Contenido principal
            control.isEmailSent.value ? ConfirmationMsg() : ResetPasswordForm(control: control),
            // Indicador de carga
            Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ],
        );
      } else {
        return control.isEmailSent.value ? ConfirmationMsg() : ResetPasswordForm(control: control);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: _buildBody(context),
    );
  }
}
