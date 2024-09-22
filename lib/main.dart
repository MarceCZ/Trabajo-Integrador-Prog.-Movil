import 'package:flutter/material.dart';
import 'pages/homePage/home_page.dart';
import 'pages/loginPage/login_page.dart';
import 'pages/signUpPage/sign_up_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/sign-up' : (context) => SignUpPage(),
      },
    );
  }
}
