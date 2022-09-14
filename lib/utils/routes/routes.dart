import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/ui/navbar/navbar_page.dart';
import 'package:boilerplate/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => NavbarPage(),
  };
}



