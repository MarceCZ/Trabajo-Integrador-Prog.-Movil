import 'package:flutter/material.dart';
import 'package:mediplan/pages/homePage/home_page.dart';
import 'pages/resetMSGPage/reset_msg_page.dart';
import 'pages/presentationPage/presentation_page.dart';
import 'pages/loginPage/login_page.dart';
import 'pages/resetPasswordPage/reset_password_page.dart';
import 'pages/profileSettingPage/profile_setting_page.dart';
import 'pages/signUpPage/sign_up_page.dart';
import 'pages/purchaseConfirmationPage/purchase_confirmation_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Gontserrat',
      ),
      initialRoute: '/presentation',
      routes: {
        '/presentation': (context) => PresentationPage(),
        '/login': (context) => LoginPage(),
        '/sign-up' : (context) => SignUpPage(),
        '/profile-setting' : (context) => ProfileSettingPage(),
        '/reset-password' : (context) => ResetPasswordPage(),
        '/reset-msg' : (context) => ResetMsgPage(),
        '/purchase-confirmation' : (context) => PurchaseConfirmationPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
