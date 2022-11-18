import 'package:boilerplate/data/service/auth_service.dart';
import 'package:boilerplate/ui/authentication/role_selection.dart';
import 'package:boilerplate/ui/login/forgot_password_page.dart';
import 'package:boilerplate/ui/register/register_petugas_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPetugasPage extends StatefulWidget {
  @override
  State<LoginPetugasPage> createState() => _LoginPetugasPageState();
}

class _LoginPetugasPageState extends State<LoginPetugasPage> {
  // const LoginPetugasPage({ Key? key }) : super(key: key);
  AuthService authService = AuthService();

  final GlobalKey<FormState> _formKey = new GlobalKey();
  bool isLoggedIn = false;
  bool isHidePassword = true;
  void togglePasswordVisibility() {
    setState(() {
      isHidePassword = !isHidePassword;
    });
  }

  void _forgotPassword(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      backgroundColor: Colors.white,
      context: context,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: ForgotPasswordPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Center(
                child: Container(
                  width: 136,
                  height: 136,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logologin.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            //create form sign in
            Container(
              padding: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //create email field
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: authService.email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.green,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        _buildPasswordForm(),
                        SizedBox(height: 10),
                        //forgot password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Forgot password?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                    text: " Click here",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _forgotPassword(context);
                                      }),
                              ]),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        //create button sign in
                        isLoggedIn
                            ? Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: Color(0xff00783E),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue)))
                            : Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),),
                                  onPressed: () async {
                                    setState(() {
                                      isLoggedIn = true;
                                    });

                                   final snapshot = await FirebaseFirestore
                                        .instance
                                        .collection('petugas')
                                        .where('email',
                                            isEqualTo: authService.email.text)
                                        .get();
                                      print("Panjang : " + snapshot.docs.length.toString());

                                    if (_formKey.currentState!.validate()) {}

                                    if (authService.email.text.isEmpty) {
                                      print("Emailnya kosong");
                                      setState(() {
                                        isLoggedIn = false;
                                      });
                                    } else {
                                      if (authService.password.text.isEmpty) {
                                        print("Passwordnya kosong");
                                        setState(() {
                                          isLoggedIn = false;
                                        });
                                      } else if (snapshot.docs.isEmpty) {
                                        isLoggedIn = false;
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  "Akun tidak terdaftar di daftar Petugas"),
                                              content: Text(
                                                  "Pastikan Username dan Password Anda Benar"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text("Close"),
                                                  style: TextButton.styleFrom( backgroundColor: Colors.red,),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                LoginPetugasPage()));
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        FirebaseAuth.instance
                                            .authStateChanges()
                                            .listen((User? user) {
                                          if (user != null) {
                                            prefs.setString('uid', user.uid);
                                            prefs.setString('nama',
                                                user.displayName.toString());
                                          }
                                        });

                                        prefs.setString(
                                            'email', authService.email.text);
                                        var email = prefs.getString('email');
                                        print('email: $email');

                                        authService.loginUserPetugas(context);
                                        Future.delayed(Duration(seconds: 3),
                                            () {
                                          setState(() {
                                            isLoggedIn = false;
                                          });
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),),
                            
                            onPressed: () async {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RoleSelection()));
                            },
                            child: Text(
                              "Kembali",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        //Don't have an account?
                        Container(
                          //create hyperlink already have an account
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "Don't have an account?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Sign Up',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterPetugasPage()));
                                      },
                                  ),
                                ])),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildPasswordForm() {
    return TextFormField(
      controller: authService.password,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      obscureText: isHidePassword,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.green,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 2,
            color: Colors.green,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 2,
            color: Colors.green,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isHidePassword = !isHidePassword;
            });
          },
          child: Icon(
            isHidePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
