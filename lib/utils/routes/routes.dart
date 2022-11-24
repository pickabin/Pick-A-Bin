import 'package:boilerplate/ui/activity/koor_activity_page.dart';
import 'package:boilerplate/ui/activity/petugas_activity_page.dart';
import 'package:boilerplate/ui/home/home_koordinator_page.dart';
import 'package:boilerplate/ui/home/home_petugas_page.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/ui/navbar/navbar_page.dart';
import 'package:boilerplate/ui/profile/profile_koordinator_main.dart';
import 'package:boilerplate/ui/profile/profile_petugas_main.dart';
import 'package:boilerplate/ui/schedule/jadwal_koor_camera_page.dart';
import 'package:boilerplate/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String profilePetugas = '/profile_petugas';
  static const String profileKoor = '/profile_koor';
  static const String jadwalKoor = '/jadwal_koor';
  static const String homeKoordinatorPage = '/home_koordinator_page';
  static const String homePetugasPage = '/home_petugas_page';
  static const String koorActivityPage = '/koor_activity_page';
  static const String petugasActivityPage = '/petugas_activity_page';


  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => NavbarPage(),
    profilePetugas: (BuildContext context) => ProfilePetugasMain(),
    profileKoor: (BuildContext context) => ProfileKoordinatorMain(),
    jadwalKoor: (BuildContext context) => JadwalKoorCameraPage(),
    homeKoordinatorPage: (BuildContext context) => HomeKoordinatorPage(),
    homePetugasPage: (BuildContext context) => HomePetugasPage(),
    koorActivityPage: (BuildContext context) => KoorActivityPage(),
    petugasActivityPage: (BuildContext context) => PetugasActivityPage(),
  };
}



