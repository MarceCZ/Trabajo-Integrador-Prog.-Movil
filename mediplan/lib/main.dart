import 'package:flutter/material.dart';
import 'package:mediplan/pages/homePage/home_page.dart';
import 'pages/presentationPage/presentation_page.dart';
import 'pages/loginPage/login_page.dart';
import 'pages/resetPasswordPage/reset_password_page.dart';
import 'pages/profileSettingPage/profile_setting_page.dart';
import 'pages/signUpPage/sign_up_page.dart';
import 'pages/purchaseConfirmationPage/purchase_confirmation_page.dart';
import 'pages/profilePage/profile_page.dart';
import 'pages/kitSettingPage/kit_setting_page.dart';
import 'pages/kitProductsPage/kit_products_page.dart';
import 'pages/kitDeliveryPage/kit_delivery_page.dart';
import 'pages/kitSubscriptionPage/kit_subscription_page.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Gontserrat',
      ),
      //debugShowCheckedModeBanner: false,
      initialRoute: '/presentation',
      routes: {
        '/presentation': (context) => PresentationPage(),
        '/login': (context) => LoginPage(),
        '/sign-up' : (context) => SignUpPage(),
        '/profile-setting' : (context) => ProfileSettingPage(),
        '/reset-password' : (context) => ResetPasswordPage(),
        '/purchase-confirmation' : (context) => PurchaseConfirmationPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/kit-setting': (context) => KitSettingPage(),
        '/kit-products': (context) => KitProductsPage(),
        '/kit-delivery': (context) => KitDeliveryPage(),
        '/kit-subscription': (context) => KitSubscriptionPage(),
      },
    );
  }
}

