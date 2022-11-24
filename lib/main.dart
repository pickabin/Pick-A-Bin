import 'dart:async';
import 'package:boilerplate/data/network/exceptions/connectivity_provider.dart';
import 'package:boilerplate/ui/my_app.dart';
import 'package:boilerplate/ui/navbar/navbar_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'di/components/service_locator.dart';

//komentar
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString('uid');

  await setPreferredOrientations();
  await setupLocator();
  return runZonedGuarded(() async {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: uid == null ? MyApp() : NavbarPage()),
    ));
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
