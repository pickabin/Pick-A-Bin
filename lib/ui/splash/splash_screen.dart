import 'dart:async';
import 'package:boilerplate/ui/navbar/navbar_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NavbarPage()));
    });
  }
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/icons/green_logo.png",
              width: 200.0,
              height: 100.0,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            "Pick A Bin",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
