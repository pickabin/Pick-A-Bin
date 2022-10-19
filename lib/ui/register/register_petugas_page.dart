import 'package:boilerplate/ui/login/login_koordinator_page.dart';
import 'package:boilerplate/ui/login/login_petugas_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import '../../data/service/auth_service.dart';

class RegisterPetugasPage extends StatefulWidget {
  const RegisterPetugasPage({Key? key}) : super(key: key);

  @override
  State<RegisterPetugasPage> createState() => _RegisterPetugasPageState();
}

class _RegisterPetugasPageState extends State<RegisterPetugasPage> {
  // Create a CollectionReference called users that references the firestore collection

  final TextEditingController _namaController = new TextEditingController();
  final TextEditingController _alamatController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _telpController = new TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey();
  final _auth = AuthService();
  bool isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      isHidePassword = !isHidePassword;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AuthService(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Sign Up',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              //create form with border
              Container(
                padding: EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Nama",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _namaController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama Harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
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
                            "Email",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email Harus Diisi';
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
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password Harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.green,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isHidePassword = !isHidePassword;
                                });
                              },
                              child: Icon(
                                isHidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.green,
                              ),
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
                          obscureText: isHidePassword,
                        ),
                        SizedBox(height: 35),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () async {
                                final String nama = _namaController.text.trim();
                                final String email =
                                    _emailController.text.trim();
                                final String password =
                                    _passwordController.text.trim();
                                if (_formKey.currentState!.validate()) {
                                  if (nama.isEmpty ||
                                      email.isEmpty ||
                                      password.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Semua Field Harus Diisi'),
                                      ),
                                    );
                                  } else {
                                    context
                                        .read<AuthService>()
                                        .registerPetugas(
                                          nama,
                                          email,
                                          password,
                                        )
                                        .then((value) async {
                                      if (value ==
                                          "Registration Successfully") {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPetugasPage()));
                                      }
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                "Sign Up",
                              )),
                        ),
                        SizedBox(height: 15),
                        Container(
                          //create hyperlink already have an account
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Already have an account? ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPetugasPage()));
                                      },
                                  ),
                                ])),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
